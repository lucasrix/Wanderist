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
    example <<-EOS
    POST /api/v1/auth/password
    {
      "email": "username@example.com",
      "redirect_url": "http://example.com"
    }
    200
    {
      "success": true,
      "message": "An email has been sent to 'username@example.com' containing instructions for resetting your password."
    }
    EOS
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
    example <<-EOS
    PATCH /api/v1/auth/password
    {
      "current_password": "current_password",
      "password": "new_password",
      "password_confirmation": "new_password"
    }
    200
    {
      "success": true,
      "data": {
        "user": {
          "id": 2,
          "provider": "email",
          "uid": "username@example.com",
          "name": null,
          "nickname": null,
          "image": null,
          "email": "username@example.com",
          "created_at": "2016-02-19T10:04:13.159Z",
          "updated_at": "2016-02-25T16:20:09.657Z"
        },
        "message": "Your password has been successfully updated."
      }
    }
    EOS

    example <<-EOS
    PUT /api/v1/auth/password
    {
      "current_password": "current_password",
      "password": "new_password",
      "password_confirmation": "new_password"
    }
    401
    {
      "success": false,
      "errors": [
        "Unauthorized"
      ]
    }
    EOS
    def update
      super
    end
  end
end
