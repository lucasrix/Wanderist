module Api::V1::Auth
  class ProviderSessionsController < ApplicationController
    resource_description do
      short 'Provider sessions manager'
      api_versions 'v1'
    end

    skip_before_action :set_user_by_token, raise: false
    skip_after_action :update_auth_header

    api! 'Provider authentication. Now just facebook.'
    param :facebook_access_token, String, desc: 'Facebook access token', required: true
    error 404, 'Token not found'

    def create
      @resource = ProviderAuthService.facebook_auth params[:facebook_access_token]
      if @resource.valid?
        create_token_info
        set_token_on_resource
        create_auth_params

        # @resource.skip_confirmation!

        sign_in(:user, @resource, store: false, bypass: false)
        @resource.save!

        update_auth_header
        render json: Response.new(@resource)
      else
        render json: Response.new(@resource), status: :forbidden
      end
    rescue Koala::Facebook::AuthenticationError
      response = Response.new
      response.add_error_message I18n.t('token_not_found')
      render json: response, status: :not_found
    end

    private

    def create_token_info
      # create token info
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token = SecureRandom.urlsafe_base64(nil, false)
      @expiry = (Time.now + DeviseTokenAuth.token_lifespan).to_i
    end

    def set_token_on_resource
      @resource.tokens[@client_id] = {
        token: BCrypt::Password.create(@token),
        expiry: @expiry
      }
    end

    def create_auth_params
      @auth_params = {
        auth_token: @token,
        client_id: @client_id,
        uid: @resource.uid,
        expiry: @expiry
      }
      @auth_params[:oauth_registration] = true
      @auth_params
    end
  end
end
