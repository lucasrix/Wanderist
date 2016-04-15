module Api::V1
  class LikesController < Api::ApiController
    resource_description do
      short 'Likes manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_resource :story
    load_resource :story_point
    load_and_authorize_resource through: [:story, :story_point]
    before_action :authorize_parent

    api! 'Create like'
    error 404, 'Story Point not found.'
    error 404, 'Story not found.'
    def create
      if @like.save
        render json: Response.new(resource, scope: current_user), status: :created
      else
        render json: Response.new(resource, scope: current_user), status: :unprocessable_entity
      end
    end

    api! 'Delete like'
    error 404, 'Story Point not found.'
    error 404, 'Story not found.'
    def destroy
      if like.destroy
        render json: Response.new(resource, scope: current_user)
      else
        render json: Response.new(resource, scope: current_user), status: :unprocessable_entity
      end
    end

    private

    def like
      resource.likes.find_by(user: current_user)
    end

    def resource
      @story || @story_point
    end

    def authorize_parent
      authorize! :read, (@story || @story_point)
    end
  end
end
