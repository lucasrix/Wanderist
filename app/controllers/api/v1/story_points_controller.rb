module Api::V1
  class StoryPointsController < Api::ApiController
    resource_description do
      short 'Story points manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource :story, only: :index
    load_and_authorize_resource :user, only: :index
    load_and_authorize_resource through: [:story, :user], shallow: true
    load_and_authorize_resource :attachment, only: [:create, :update]

    before_action :set_service, only: [:index]
    before_action :authorize_stories, only: [:create, :update]

    def_param_group :location do
      param :location, Hash,  action_aware: true, desc: 'Location info' do
        param :latitude, Float, desc: 'Latitude coordinate', required: true
        param :longitude, Float, desc: 'Longitude coordinate', required: true
        param :address, String, desc: 'Address', required: false
      end
    end

    def_param_group :story_point do
      param :caption, String, required: false, desc: 'Caption', action_aware: true
      param :text, String, required: false, desc: 'Text'
      param :attachment_id, Integer, required: false, desc: 'Attachment'
      param_group :location
      param :tags, Array, of: String, desc: 'List of tags'
    end

    api! 'List of story points'
    param_group :location, as: :create
    param :radius, Float, desc: 'Radius of area in miles', required: true
    def index
      origin_params = build_origin_params
      if origin_params
        @story_points = @service.within_origin(*origin_params)
        render json: Response.new(@story_points, StoryPointSerializer, scope: current_user)
      else
        response = Response.new
        response.add_error_message I18n.t('story_points.missing_params')
        render json: response
      end
    end

    api! 'Show a story point info'
    error 404, 'Story point not found'
    def show
      render json: Response.new(@story_point, scope: current_user)
    end

    api! 'Create a story point'
    param :kind, StoryPoint::KINDS, required: true, desc: 'Kind'
    param :story_ids, Array, of: Integer, required: false, desc: 'Array of story ids'
    param_group :story_point
    see 'attachments#create', 'Attachment'
    see 'stories#create', 'Story'
    def create
      @story_point.kind = StoryPoint.kinds[params[:kind]]
      @story_point.location = Location.create(location_params)
      create_entity(@story_point)
    end

    api! 'Update a story point'
    param_group :story_point
    error 404, 'Story Point not found.'

    def update
      update_entity(@story_point, story_point_params)
    end

    api! 'Delete a story point'
    error 404, 'Story Point not found.'

    def destroy
      destroy_entity(@story_point)
    end

    private

    def build_origin_params
      return unless origin_params_valid?
      location_params.values << params[:radius]
    end

    def origin_params_valid?
      Location.new(location_params).valid? && params[:radius].present?
    end

    def authorize_stories
      if params[:story_ids].present?
        Story.accessible_by(current_ability, :update).find(params[:story_ids])
      end
    end

    def set_service
      @story_points = current_user.story_points if params[:scope] == 'current_user'
      @service ||= StoryPointsService.new(@story_points)
    end

    def story_point_params
      params[:story_ids] ||= []
      params.permit(:caption, :text, :attachment_id, :kind, story_ids: [])
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude, :address)
    end
  end
end
