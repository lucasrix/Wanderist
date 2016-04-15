module Api::V1
  class FollowingsController < Api::ApiController
    resource_description do
      short 'Followings manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_resource :story
    load_resource :user
    load_and_authorize_resource through: [:story, :user]
    before_action :authorize_parent

    api! 'Create following'
    error 404, 'User not found.'
    error 404, 'Story not found.'
    def create
      if @following.save
        render json: Response.new(resource), status: :created
      else
        render json: Response.new(resource), status: :unprocessable_entity
      end
    end

    api! 'Delete following'
    error 404, 'Story not found.'
    error 404, 'User not found.'
    def destroy
      if following.destroy
        render json: Response.new(resource)
      else
        render json: Response.new(resource), status: :unprocessable_entity
      end
    end

    private

    def following
      resource.followings.find_by(user: current_user)
    end

    def resource
      @story || @user
    end

    def authorize_parent
      authorize! :read, resource
    end
  end
end
