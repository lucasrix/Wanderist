module Api::V1::Auth
  class SessionsController < DeviseTokenAuth::SessionsController
    resource_description do
      short 'Sessions manager'
      api_versions 'v1'

      description <<-EOS
        == Token Header Format
        The authentication information should be included by the client in the headers of each request.
        The headers follow the {RFC 6750 Bearer Token}[http://tools.ietf.org/html/rfc6750] format:
        === Authentication headers example:
          "access-token": "wwwww",
          "token-type":   "Bearer",
          "client":       "xxxxx",
          "expiry":       "yyyyy",
          "uid":          "zzzzz"
        The authentication headers consists of the following params:
        +access-token+:: This serves as the user's password for each request. A hashed version of this value is stored in the database for later comparison. This value should be changed on each request.
        +client+:: This enables the use of multiple simultaneous sessions on different clients. (For example, a user may want to be authenticated on both their phone and their laptop at the same time.)
        +expiry+:: The date at which the current session will expire. This can be used by clients to invalidate expired tokens without the need for an API request.
        +uid+:: A unique value that is used to identify the user. This is necessary because searching the DB for users by their access token will make the API susceptible to {timing attacks}[http://codahale.com/a-lesson-in-timing-attacks/].


      EOS

    end

    api! 'Email authentication.'
    param :email, String, desc: 'Email address'
    param :password, String, desc: 'Password', required: true
    error 401, 'Invalid login credentials. Please try again.'
    error 401, 'A confirmation email was sent to your account at {{email}}.' +
                 'You must follow the instructions in the email before your account ' +
                 'can be activated'
    error 403, 'Email already in use'
    def create
      super
    end

    api :DELETE, '/auth/sessions', "Use this route to end the user's current session. This route will invalidate the user's authentication token."

    def destroy
      super
    end

  end
end
