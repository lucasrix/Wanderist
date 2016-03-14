module Api::V1
  class StoryPointsController < Api::ApiController
    resource_description do
      short 'Story points manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource :story, only: [:index]
    load_and_authorize_resource through: :story, shallow: true
    load_and_authorize_resource :attachment, only: [:create, :update]

    before_action :set_service, only: [:index]

    def_param_group :location do
      param :location, Hash,  action_aware: true, desc: 'Location info' do
        param :latitude, Float, desc: 'Latitude coordinate', required: true
        param :longitude, Float, desc: 'Longitude coordinate', required: true
      end
    end

    def_param_group :story_point do
      param :caption, String, required: true, desc: 'Caption', action_aware: true
      param :text, String, required: false, desc: 'Text'
      param :attachment_id, Integer, required: false, desc: 'Attachment'
      param_group :location
      param :tags, Array, of: String, desc: 'List of tags'
    end

    api! 'List of story points'
    param_group :location, as: :create
    param :radius, Float, desc: 'Radius of area in miles', required: true
    example <<-EOS
    GET /api/v1/story_points
    {
      "location[latitude]": 48.4500,
      "location[longitude]": 34.9833,
      "radius": 5.0
    }
    200
    {
      "success": true,
      "data": {
        "story_points": [
          {
            "id": 13,
            "kind": "photo",
            "caption": "My Awesome Story Point",
            "attachment_id": 1,
            "location": {
              "id": 1,
              "latitude": 48.4500,
              "longitude": 34.9833
            },
            "tags": [
              {
                "id": 1,
                "name": "tag1"
              },
              {
                "id": 2,
                "name": "tag2"
              },
              {
                "id": 3,
                "name": "tag3"
              }
            ]
          },
          {
            "id": 14,
            "kind": "photo",
            "caption": "My Awesome Story Point 2",
            "attachment_id": 1,
            "location": {
              "id": 1,
              "latitude": 48.4501,
              "longitude": 34.9843
            },
            "tags": []
          },
        ]
      }
    }
    EOS
    def index
      if params[:location].present? and params[:location][:latitude].present? and params[:location][:longitude].present? and params[:radius].present?
        @story_points = @service.within_origin(params[:location][:latitude], params[:location][:longitude], params[:radius])
        render json: Response.new(@story_points, PreviewStoryPointSerializer)
      else
        response = Response.new
        response.add_error_message I18n.t('story_points.missing_params')
        render json: response
      end
    end

    api! 'Show a story point info'
    error 404, 'Story point not found'

    example <<-EOS
    GET /api/v1/story_points/1
    200
    {
      "success": true,
      "data": {
        "story_point": {
          "id": 1,
          "kind": "photo",
          "caption": "My Awesome Story Point",
          "attachment": {
            "id": 1,
            "file_url": "FILE_URL"
          },
          "location": {
            "id": 1,
            "latitude": 48.4500,
            "longitude": 34.9833
          },
          "tags": [
            {
              "id": 1,
              "name": "tag1"
            },
            {
              "id": 2,
              "name": "tag2"
            },
            {
              "id": 3,
              "name": "tag3"
            }
          ]
        }
      },
      "error": {
        "error_messages": [],
        "details": {}
      }
    }
    EOS
    def show
      render json: Response.new(@story_point)
    end

    api! 'Create a story point'
    param :kind, StoryPoint::KINDS, required: true, desc: 'Kind'
    param_group :story_point
    see "attachments#create", "Attachment"
    see "stories#create", "Story"
    def create
      @story_point.kind = StoryPoint::kinds[params[:kind]]
      @story_point.location = Location.create(location_params)

      # if params[:tags].present?
      #   tags_params = params[:tags].map do |tag|
      #     {
      #       name: tag
      #     }
      #   end
      #   @story_point.tags.build(tags_params)
      # end

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

    def set_service
      @service = StoryPointsService.new(@story_points)
    end

    def story_point_params
      params.permit(:caption, :text, :attachment_id, :kind)
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end

  end
end