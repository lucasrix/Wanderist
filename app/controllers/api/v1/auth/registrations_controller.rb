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
    param :password_confirmation, String, required: true, desc: 'Password confirmation'
    example <<-EOS
    POST /api/v1/auth
    {
      "email": "username@example.com",
      "first_name": "John",
      "last_name": "Smith",
      "password": "password",
      "password_confirmation": "password"
    }
    403
    {
      "status": "error",
      "data": {
        "user": {
          "id": null,
          "provider": "email",
          "uid": "",
          "email": "username@example.com",
          "created_at": null,
          "updated_at": null
        }
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

    example <<-EOS
    POST /api/v1/auth
    {
      "email": "username2@example.com",
      "first_name": "John",
      "last_name": "Smith",
      "photo": "{BLOB DATA}"
      "password": "password",
      "password_confirmation": "password"
    }
    201
    {
      "status": "success",
      "data": {
        "user": {
          "id": null,
          "provider": "email",
          "uid": "username2@example.com",
          "email": "username2@example.com",
          "created_at": "2016-02-22T11:57:34.638Z",
          "updated_at": "2016-02-22T11:57:34.638Z",
          "profile": {
            "id": 1,
            "first_name": "John",
            "last_name": "Smith",
            "about": null,
            "photo": "{URL}",
            "home_city": null
            "personal_url": null
          }
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
