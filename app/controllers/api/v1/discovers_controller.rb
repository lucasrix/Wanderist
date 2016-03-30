module Api::V1
  class DiscoversController < Api::ApiController
    resource_description do
      short 'Discovers manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    def_param_group :location do
      param :location, Hash,  action_aware: true, desc: 'Location info' do
        param :latitude, Float, desc: 'Latitude coordinate', required: true
        param :longitude, Float, desc: 'Longitude coordinate', required: true
      end
    end

    api! 'List of discovered points and stories'
    param_group :location, as: :create
    param :radius, Float, desc: 'Radius of area in miles', required: false
    param :page, Integer, desc: 'Pagination page', required: false
    description <<-EOS
      If location and radius are presented - "Near You" mode.\n
      If location is presented and radius not presented - "City" mode.\n
      If location ans radius aren't presented - "Whole World" mode.\n
    EOS
    example <<-EOS
    GET /api/v1/discover?location[latitude]=10.66&location[longitude]=50.39&radius=1&page=1
    200
    {
      "status": "success",
      "data": {
        "discovered": [
          {
            "id": 1149,
            "type": "StoryPoint"
            "caption": "freegan",
            "kind": "photo",
            "text": "Locavore lumbersexual franzen. Pitchfork single-origin coffee salvia park poutine locavore. Cornhole literally microdosing viral.",
            "user": {
              "id": 4495,
              "provider": "email",
              "uid": "janick_mueller@anderson.name",
              "email": "janick_mueller@anderson.name",
              "created_at": "2016-03-28T13:59:22.831Z",
              "updated_at": "2016-03-28T13:59:22.831Z",
              "profile": {
                "id": 8783,
                "first_name": null,
                "last_name": null,
                "city": null,
                "url": null,
                "about": null,
                "photo_url": null,
                "posts_count": 0
              }
            },
            "location": {
              "id": 1481,
              "latitude": 10.66,
              "longitude": 50.39
            },
            "attachment": {
              "id": 198,
              "file_url": "/uploads/attachment/file/198/sample.jpg"
            },
            "tags": [
              {
                "id": 3,
                "name": "voluptatem"
              },
              {
                "id": 4,
                "name": "iste"
              }
            ]
          },
          {
            "id": 1243,
            "type": "Story",
            "name": "farm-to-table",
            "description": "Veniam nisi sit. In dolorem quia placeat ipsa quaerat. Dicta earum laudantium quia et sapiente.",
            "discoverable": true
            "user": {
              "id": 4493,
              "provider": "email",
              "uid": "stefan@cummings.org",
              "email": "stefan@cummings.org",
              "created_at": "2016-03-28T13:59:22.727Z",
              "updated_at": "2016-03-28T13:59:22.727Z",
              "profile": {
                "id": 8779,
                "first_name": null,
                "last_name": null,
                "city": null,
                "url": null,
                "about": null,
                "photo_url": null,
                "posts_count": 0
              },
            },
            "story_points": [
              {
                "id": 1148,
                "caption": "chicharrones",
                "kind": "photo",
                "text": "Blue bottle godard ennui blog post-ironic. Venmo bushwick vinegar kombucha kinfolk salvia. Bitters kombucha hammock tote bag swag tattooed occupy.",
                "user": {
                  "id": 4493,
                  "provider": "email",
                  "uid": "stefan@cummings.org",
                  "email": "stefan@cummings.org",
                  "created_at": "2016-03-28T13:59:22.727Z",
                  "updated_at": "2016-03-28T13:59:22.727Z",
                  "profile": {
                    "id": 8779,
                    "first_name": null,
                    "last_name": null,
                    "city": null,
                    "url": null,
                    "about": null,
                    "photo_url": null,
                    "posts_count": 0
                  }
                },
                "location": {
                  "id": 1481,
                  "latitude": 10.66,
                  "longitude": 50.39
                },
                "attachment": {
                  "id": 197,
                  "file_url": "/uploads/attachment/file/197/sample.jpg"
                },
                "tags": [
                  {
                    "id": 1,
                    "name": "dolor"
                  },
                  {
                    "id": 2,
                    "name": "quidem"
                  }
                ]
              }
            ]
          }
        ]
      },
      "error": {
        "error_messages": [],
        "details": {}
      }
    }
    EOS
    def discover
      origin_params = build_origin_params
      if origin_params
        @story_points = @service.within_origin(*origin_params)
        render json: Response.new(@story_points, StoryPointSerializer)
      else
        response = Response.new
        response.add_error_message I18n.t('story_points.missing_params')
        render json: response
      end
    end

    private

    def build_origin_params
      return unless origin_params_valid?
      location_params.values << params[:radius]
    end

    def origin_params_valid?
      Location.new(location_params).valid? && params[:radius].present?
    end

    def set_service
      @service = StoryPointsService.new(@story_points)
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end
  end
end
