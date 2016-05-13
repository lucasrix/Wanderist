module Api::V1
  class UsersController < Api::ApiController
    resource_description do
      short 'User manager'
      api_versions 'v1'
      error 403, 'Forbidden action'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource only: [:followers, :followed, :update]

    api! 'Get list of followers that follow user'
    def followers
      resource = current_user.followers
      render json: Response.new(resource, scope: current_user)
    end

    api! 'Get list of users who followed by user'
    def followed
      resource = current_user.followed
      render json: Response.new(resource, scope: current_user)
    end

    api! 'Update user  email'
    param :email, String, required: false, desc: 'New user email'
    error 422, 'Validation failed'
    def update
      update_entity(current_user, user_params)
    end

    private

    def user_params
      params.permit(:email)
    end
  end
end
