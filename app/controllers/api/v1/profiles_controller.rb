module Api::V1
  class ProfilesController < Api::ApiController
    resource_description do
      short 'Profile manager'
      api_versions 'v1'
      error 403, 'Forbidden action'
    end

    load_and_authorize_resource through: :current_user, singleton: true

    api! 'Update a profile'
    param :photo, File, required: false, desc: 'New profile photo'
    param :first_name, String, required: false, desc: 'First name'
    param :last_name, String, required: false, desc: 'Last name'
    param :city, String, required: false, desc: 'City'
    param :url, String, required: false, desc: 'URL'
    param :about, String, required: false, desc: 'About user info.'
    error 422, 'Validation failed'

    def update
      update_entity(@profile, profile_params)
    end

    private
    def profile_params
      params.permit(:first_name, :last_name, :about, :url, :city, :photo)
    end
  end
end
