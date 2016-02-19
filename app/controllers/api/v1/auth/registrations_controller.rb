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

    def create
      super
    end

  end
end
