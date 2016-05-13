module Api::V1
  class DiscoversController < Api::ApiController
    resource_description do
      short 'Discovers manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    def_param_group :location do
      param :location, Hash,  action_aware: true, desc: 'Location info' do
        param :latitude, Float, desc: 'Latitude coordinate', required: true
        param :longitude, Float, desc: 'Longitude coordinate', required: true
      end
    end

    api! 'List of discovered points and stories'
    param_group :location, as: :create
    param :radius, Float, desc: 'Radius of area in miles', required: false
    param :page, Integer, desc: 'Pagination page', required: false
    description <<-EOS
      If location and radius are presented - "Near You" mode.\n
      If location is presented and radius not presented - "City" mode.\n
      If location and radius aren't presented - "Whole World" mode.\n
    EOS

    def discover
      if origin_params_valid?
        @discover = build_discover(discovered_story_points)
        render json: DiscoverResponse.new(@discover, scope: current_user)
      else
        response = Response.new
        response.add_error_message I18n.t('story_points.missing_params')
        render json: response
      end
    end

    private

    def discovered_story_points
      @story_points = StoryPoint.accessible_by(current_ability)
      DiscoversQuery.new(params, @story_points).load_relation
    end

    def build_discover(discovered)
      BuildDiscoverService.call(discovered, current_ability, params[:page])
    end

    def origin_params_valid?
      params[:location].present? ? Location.new(location_params).valid? : true
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end
  end
end
