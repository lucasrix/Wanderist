module Api::V1
  class LocationsController < Api::ApiController
    resource_description do
      short 'Locations manager'
      api_versions 'v1'
      error 401, 'Unauthorized action'
    end

    load_and_authorize_resource only: :cities

    api! 'Lists of available cities'
    param :page, Integer, desc: 'Pagination page', required: false
    def cities
      cities = @locations.cities.page(params[:page])
      render json: Response.new(cities)
    end
  end
end

