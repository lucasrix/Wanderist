module Api::V1
  class GadgetsController < Api::ApiController
    resource_description do
      short 'Gadget manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource through: :current_user

    api! 'Create gadget'
    param :token, String, desc: 'Gadget token', required: true
    def create
      create_entity(@gadget)
    end

    api! 'Delete gadget'
    error 404, 'Gadget not found.'
    def destroy
      destroy_entity(@gadget)
    end

    private

    def gadget_params
      params.permit(:token)
    end
  end
end
