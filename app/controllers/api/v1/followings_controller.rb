module Api::V1
  class FollowingsController < Api::ApiController
    resource_description do
      short 'Followings manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    before_action :authorize_parent
    load_resource :story
    load_and_authorize_resource :following, only: :destroy, through: :story

    api! 'Create following'
    example <<-EOS
    POST /api/v1/stories/1/following
    200
    {
      "success": true,
      "data": {
        "story": {
          "id": 1,
          "followed": true
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


    api! 'Delete following'
    error 404, 'Story not found.'
    example <<-EOS
    DELETE /api/v1/story_points/1/following
    200
    {
      "success": true,
      "data": {
        "story": {
          "id": 1,
          "followed": false
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
      authorize! :read, @story
    end
  end
end

