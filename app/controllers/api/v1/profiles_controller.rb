module Api::V1
  class ProfilesController < Api::ApiController
    resource_description do
      short 'Profile manager'
      api_versions 'v1'
      error 403, 'Forbidden action'
    end

    def_param_group :location do
      param :location, Hash,  action_aware: true, desc: 'Location info' do
        param :latitude, Float, desc: 'Latitude coordinate', required: true
        param :longitude, Float, desc: 'Longitude coordinate', required: true
      end
    end

    load_and_authorize_resource through: :current_user, singleton: true, only: [:update]

    api! 'Show a profile'
    error 404, 'Profile not found'
    def show
      if params[:id].present?
        @profile = Profile.find(params[:id])
        authorize! :read, @profile
        render json: Response.new(@profile, ProfileSerializer)
      else
        @profile = current_user.profile
        render json: Response.new(@profile, MyProfileSerializer)
      end
    end

    api! 'Update a profile'
    param_group :location
    param :photo, File, required: false, desc: 'New profile photo'
    param :first_name, String, required: false, desc: 'First name'
    param :last_name, String, required: false, desc: 'Last name'
    param :city, String, required: false, desc: 'City'
    param :url, String, required: false, desc: 'URL'
    param :about, String, required: false, desc: 'About user info.'
    error 422, 'Validation failed'

    def update
      set_location if params[:location].present?
      update_entity(@profile, profile_params)
    end

    private

    def set_location
      if @profile.location
        @profile.location.update_attributes(location_params)
      else
        @profile.create_location(location_params)
      end
    end

    def profile_params
      params.permit(:first_name, :last_name, :about, :url, :city, :photo)
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end
  end
end
