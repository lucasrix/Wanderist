module Api::V1::Auth
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    resource_description do
      short 'Users manager'
      api_versions 'v1'

    end

    api! 'Email registration. A verification email will be sent to the email address provided.'
    param :email, String, required: true, desc: 'Email address'
    param :first_name, String, required: true, desc: 'First name'
    param :last_name, String, required: true, desc: 'Last name'
    param :photo, File, required: false, desc: 'Photo'
    param :password, String, required: true, desc: 'Password'
    param :password_confirmation, String, required: false, desc: 'Password confirmation'

    def create
      super do |user|
        update_profile(user)
      end
    end

    protected

    def render_create_success
      render json: Response.new(@resource), status: :created
    end

    def render_create_error
      render json: Response.new(@resource), status: 403
    end

    def render_create_error_email_already_exists
      render json: {
        status: 'error',
        data: @resource.as_json,
        error: {
          error_messages: [I18n.t("devise_token_auth.registrations.email_already_exists", email: @resource.email)]
        }
      }, status: 403
    end

    def render_update_error
      render json: {
        status: 'error',
        error: {
          error_messages: @resource.errors.full_messages,
          details: @resource.errors.to_hash
        }
      }, status: 403
    end

    def render_update_error_user_not_found
      render json: {
        status: 'error',
        error: {
          error_messages: [I18n.t("devise_token_auth.registrations.user_not_found")]
        }
      }, status: 404
    end

    def render_destroy_error
      render json: {
        status: 'error',
        error: {
          error_messages: [I18n.t("devise_token_auth.registrations.account_to_destroy_not_found")]
        }
      }, status: 404
    end

    private
    def update_profile(user)
      user.profile.update!(profile_params)
    end

    def profile_params
      params.permit(:photo, :first_name, :last_name)
    end

  end
end
