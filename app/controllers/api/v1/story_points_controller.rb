module Api::V1
  class StoryPointsController < Api::ApiController
    resource_description do
      short 'Story points manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource
    load_and_authorize_resource :attachment, only: [:create, :update]
    load_and_authorize_resource :story, only: [:create, :update]

    before_action :set_service

    def_param_group :location do
      param :location, Hash,  action_aware: true, desc: "Center location info", required: true do
        param :latitude, Float, desc: "Latitude coordinate", required: true
        param :longitude, Float, desc: "Longitude coordinate", required: true
      end
    end

    api! 'List of story points'
    param_group :location, as: :create
    param :radius, Float, desc: "Radius of area", required: true
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
      render json: Response.new(@service.get_story_points)
    end

    api! 'Create a story point'
    param :kind, StoryPoint::KINDS, required: true, desc: 'Kind'
    param :caption, String, required: true, desc: 'Caption'
    param :attachment_id, Integer, required: false, desc: 'Attachment'
    param_group :location
    param :tags, Array, of: String, desc: "List of tags"
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

      if @story_point.save
        render json: Response.new(@story_point), status: :created
      else
        render json: Response.new(@story_point), status: :unprocessable_entity
      end
    end

    api! 'Update a story point'
    param :kind, StoryPoint::KINDS, required: false, desc: 'Kind'
    param :caption, String, required: false, desc: 'Caption'
    param :attachment_id, Integer, required: false, desc: 'Attachment'
    param :story_id, Integer, required: false, desc: 'Story id'
    param_group :location
    param :tags, Array, of: String, desc: "List of tags"
    error 404, 'Story Point not found.'

    def update
      if @story_point.update(story_point_params)
        render json: Response.new(@story_point)
      else
        render json: Response.new(@story_point), status: :unprocessable_entity
      end
    end


    api! 'Delete a story point'
    error 404, 'Story Point not found.'

    def destroy
      if @story_point.destroy
        render json: Response.new(@story_point)
      else
        render json: Response.new(@story_point), status: :unprocessable_entity
      end
    end

    private

    def set_service
      @service = StoryPointsService.new
    end

    def story_point_params
      params.permit(:caption, :attachment_id, :kind, :story_id)
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end

  end
end