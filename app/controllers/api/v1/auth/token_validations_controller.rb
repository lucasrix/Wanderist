module Api::V1::Auth
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    resource_description do
      short 'Token manager'
      api_versions 'v1'

    end

    api! 'Use this route to validate tokens on return visits to the client.'
    param :uid, Integer, desc: 'UID', required: !true
    param :client, String, desc: 'Client', required: !true
    param "access-token", String, desc: 'Access Token', required: !true

    def validate_token
      super
    end
  end
end