module Api::V1::Auth
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    resource_description do
      short 'Users manager'
      api_versions 'v1'

    end

    api! 'Email registration. A verification email will be sent to the email address provided.'
    param :email, String, required: true, desc: 'Email address'
    param :password, String, required: true, desc: 'Password'
    param :password_confirmation, String, required: true, desc: 'Password confirmation'
    example <<-EOS
    POST /api/v1/auth
    {
      "email": "username@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    403
    {
      "status": "error",
      "data": {
        "id": null,
        "provider": "email",
        "uid": "",
        "name": null,
        "nickname": null,
        "image": null,
        "email": "username@example.com",
        "created_at": null,
        "updated_at": null
      },
      "error": {
        "error_messages": [
          "Email already in use"
        ],
        "details": {
          "email": [
            "already in use"
          ]
        }
      }
    }
    EOS

    def create
      super
    end

    protected

    def render_create_error
      render json: {
        status: 'error',
        data: @resource.as_json,
        error: {
          error_messages: @resource.errors.full_messages,
          details: @resource.errors.to_hash
        }
      }, status: 403
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

  end
end
