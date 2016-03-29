module Api::V1
  class LikesController < Api::ApiController
    resource_description do
      short 'Likes manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    before_action :authorize_parent
    load_resource :story
    load_resource :story_point
    load_and_authorize_resource :like, only: :destroy, through: [:story, :story_point]

    api! 'Create like'
    example <<-EOS
    POST /api/v1/story_points/1/like
    200
    {
      "success": true,
      "data": {
        "story_point": {
          "id": 1,
          "likes": 3
        }
      },
      "error": {
        "error_messages": [],
        "details": {}
      }
    }
    EOS
    def create
    end


    api! 'Delete like'
    error 404, 'Story Point not found.'
    example <<-EOS
    DELETE /api/v1/story_points/1/like
    200
    {
      "success": true,
      "data": {
        "story_point": {
          "id": 1,
          "likes": 2
        }
      },
      "error": {
        "error_messages": [],
        "details": {}
      }
    }
    EOS
    def destroy
    end

    private

    def authorize_parent
      authorize! :read, (@story || @story_point)
    end
  end
end

