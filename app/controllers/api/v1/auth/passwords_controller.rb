module Api::V1::Auth
  class PasswordsController < DeviseTokenAuth::PasswordsController
    resource_description do
      short 'Passwords manager'
      api_versions 'v1'
    end

    api! 'Use this route to send a password reset confirmation email to users that registered by email.'
    param :email, String, required: true, desc: 'Email'
    param :redirect_url, String, required: true, desc: 'Redirect URL'
    error 404, 'Unable to find user with email {{email}}.'
    def create
      super
    end

    def edit
      super
    end

    api! 'Use this route to change users passwords.'
    param :password, String, required: true, desc: 'Password'
    param :password_confirmation, String, required: true, desc: 'Password confirmation'
    # error 404, 'Unable to find user with email {{email}}.'
    def update
      super
    end

    protected

    def render_create_error
      if @resource
        super
      else
        response = Response.new
        response.add_error_message I18n.t("devise_token_auth.passwords.user_not_found", email: @email)
        render json: response, status: 404
      end
    end

    def render_update_success
      render json: Response.new(@resource)
    end
  end
end
