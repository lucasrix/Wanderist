module Api::V1::Auth
  class ProviderSessionsController < ApplicationController
    resource_description do
      short 'Provider sessions manager'
      api_versions 'v1'
    end

    skip_before_action :set_user_by_token, raise: false
    # skip_after_action :update_auth_header

    api! 'Provider authentication. Now just facebook.'
    param :facebook_access_token, String, desc: 'Facebook access token', required: true
    error 404, 'Token not found'

    example <<-EOS
    POST /api/v1/auth/provider_sessions
    {
      "facebook_access_token": "CAACEdE.....JQZDZD"
    }
    200
    {
      "status": "success",
      "data": {
        "id": 1,
        "provider": "facebook",
        "uid": "100001557261211",
        "name": "George Zhukov",
        "username": "username@example.com",
        "image": null,
        "email": "username@example.com",
        "created_at": "2016-02-29T15:16:11.119Z",
        "updated_at": "2016-02-29T15:16:19.786Z"
      }
    }
    EOS

    example <<-EOS
    POST /api/v1/auth/provider_sessions
    {
      "facebook_access_token": "wrong token"
    }
    404
    {
      "status": "error",
      "error": {
        "error_messages": [
          "User not found"
        ]
      }
    }
    EOS

    def create
      begin
        @resource = ProviderAuthService::facebook_auth params[:facebook_access_token]
        if @resource.valid?
          create_token_info
          set_token_on_resource
          create_auth_params

          # @resource.skip_confirmation!

          sign_in(:user, @resource, store: false, bypass: false)
          @resource.save!

          render json: {
            status: 'success',
            data: @resource.as_json
          }, status: 200
        else
          render json: {
            status: 'error',
            data: @resource.as_json,
            error: {
              error_messages: @resource.errors.full_messages,
              details: @resource.errors.to_hash
            }
          }, status: 403
        end
      rescue Koala::Facebook::AuthenticationError
        render json: {
          status: 'error',
          error: {
            error_messages: [I18n.t("user_not_found")]
          }
        }, status: 404
      end
    end


    private
    def create_token_info
      # create token info
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)
      @expiry    = (Time.now + DeviseTokenAuth.token_lifespan).to_i
    end

    def set_token_on_resource
      @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: @expiry
      }
    end

    def create_auth_params
      @auth_params = {
          auth_token:     @token,
          client_id: @client_id,
          uid:       @resource.uid,
          expiry:    @expiry
      }
      @auth_params.merge!(oauth_registration: true)
      @auth_params
    end
  end
end
