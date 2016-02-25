module Api::V1::Auth
  class SessionsController < DeviseTokenAuth::SessionsController
    resource_description do
      short 'Sessions manager'
      api_versions 'v1'

      description <<-EOS
        ### Token Header Format

        The authentication information should be included by the client in the headers of each request. The headers follow the [RFC 6750 Bearer Token](http://tools.ietf.org/html/rfc6750) format:

        ##### Authentication headers example:

            "access-token": "wwwww",
            "token-type":   "Bearer",
            "client":       "xxxxx",
            "expiry":       "yyyyy",
            "uid":          "zzzzz"


        The authentication headers consists of the following params:

        | param | description |
        |---|---|
        | **`access-token`** | This serves as the user's password for each request. A hashed version of this value is stored in the database for later comparison. This value should be changed on each request. |
        | **`client`** | This enables the use of multiple simultaneous sessions on different clients. (For example, a user may want to be authenticated on both their phone and their laptop at the same time.) |
        | **`expiry`** | The date at which the current session will expire. This can be used by clients to invalidate expired tokens without the need for an API request. |
        | **`uid`** | A unique value that is used to identify the user. This is necessary because searching the DB for users by their access token will make the API susceptible to [timing attacks](http://codahale.com/a-lesson-in-timing-attacks/). |

        The authentication headers required for each request will be available in the response from the previous request. If you are using the [ng-token-auth](https://github.com/lynndylanhurley/ng-token-auth) AngularJS module or the [jToker](https://github.com/lynndylanhurley/j-toker) jQuery plugin, this functionality is already provided.


        ## About token management

        Tokens should be invalidated after each request to the API. The following diagram illustrates this concept:

        ![password reset flow](https://github.com/lynndylanhurley/ng-token-auth/raw/master/test/app/images/flow/token-update-detail.jpg)

        During each request, a new token is generated. The `access-token` header that should be used in the next request is returned in the `access-token` header of the response to the previous request. The last request in the diagram fails because it tries to use a token that was invalidated by the previous request.

        The only case where an expired token is allowed is during [batch requests](#about-batch-requests).

        ## About batch requests

        By default, the API should update the auth token for each request ([read more](#about-token-management)). But sometimes it's necessary to make several concurrent requests to the API, for example:

        #####Batch request example

            $scope.getResourceData = function() {

              $http.get('/api/restricted_resource_1').success(function(resp) {
                // handle response
                $scope.resource1 = resp.data;
              });

              $http.get('/api/restricted_resource_2').success(function(resp) {
                // handle response
                $scope.resource2 = resp.data;
              });
            };


        In this case, it's impossible to update the `access-token` header for the second request with the `access-token` header of the first response because the second request will begin before the first one is complete. The server must allow these batches of concurrent requests to share the same auth token. This diagram illustrates how batch requests are identified by the server:

        ![batch request overview](https://github.com/lynndylanhurley/ng-token-auth/raw/master/test/app/images/flow/batch-request-overview.jpg)

        The "5 second" buffer in the diagram is the default.

        The following diagram details the relationship between the client, server, and access tokens used over time when dealing with batch requests:

        ![batch request detail](https://github.com/lynndylanhurley/ng-token-auth/raw/master/test/app/images/flow/batch-request-detail.jpg)

        Note that when the server identifies that a request is part of a batch request, the user's auth token is not updated. The auth token will be updated for the first request in the batch, and then that same token will be returned in the responses for each subsequent request in the batch (as shown in the diagram).

        # Security


        This auth tokens are:
        * [changed after every request](#about-token-management) (can be [turned off](https://github.com/lynndylanhurley/devise_token_auth/#initializer-settings)),
        * [of cryptographic strength](http://ruby-doc.org/stdlib-2.1.0/libdoc/securerandom/rdoc/SecureRandom.html),
        * hashed using [BCrypt](https://github.com/codahale/bcrypt-ruby) (not stored in plain-text),
        * securely compared (to protect against timing attacks),
        * invalidated after 2 weeks (thus requiring users to login again)

        These measures were inspired by [this stackoverflow post](http://stackoverflow.com/questions/18605294/is-devises-token-authenticatable-secure).



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
