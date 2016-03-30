module Api::V1
  class StoriesController < Api::ApiController
    resource_description do
      short 'Stories manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource only: [:show, :create, :update, :destroy]
    load_and_authorize_resource through: :current_user, only: :my_stories

    def_param_group :story do
      param :name, String, desc: 'Name', required: true, action_aware: true
      param :description, String, desc: 'Description', required: false, action_aware: true
      param :discoverable, [true, false], desc: 'Discoverable state', required: true, action_aware: true
      param :story_point_ids, Array, of: Integer, required: false
    end

    api! "Show my stories"
    param :page, Integer, desc: 'Page number for pagination', required: false
    def my_stories
      stories = @stories.page(params[:page])
      render json: Response.new(stories)
    end


    api! 'Show a story info'
    error 404, 'Story not found'

    example <<-EOS
    GET /api/v1/stories/1
    200
    {
      "success": true,
      "data": {
        "story": {
          "id": 1243,
          "name": "farm-to-table",
          "description": "Veniam nisi sit. In dolorem quia placeat ipsa quaerat. Dicta earum laudantium quia et sapiente.",
          "discoverable": true,
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
      },
      "error": {
        "error_messages": [],
        "details": {}
      }
    }
    EOS
    def show
      render json: Response.new(@story)
    end

    api! 'Create a story'
    param_group :story
    error 422, 'Validation error.'
    def create
      create_entity(@story)
    end

    api! 'Update a story'
    param_group :story
    error 422, 'Validation error.'
    def update
      if params[:story_point_ids].present?
        StoryPoint.accessible_by(current_ability, :read).find(params[:story_point_ids])
      end

      update_entity(@story, story_params)
    end

    api! 'Delete a story'
    error 404, 'Story not found.'
    error 422, 'Validation errors.'
    def destroy
      destroy_entity(@story)
    end

    private
    def story_params
      params.permit(:name, :description, :discoverable, story_point_ids: [])
    end
  end
end
