class AssignGeodataService < BaseService

  def initialize(location)
    @location = location
  end

  def call
    load_geodata
    set_geodata
  end

  private

  def load_geodata
    @geodata = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(location_params)
    unless @geodata.success
      @location.errors.add(:geocode_error, I18n.t(:geocode_error, scope: [:locations, :errors]))
    end
  end

  def set_geodata
    return if @location.errors.any?
    @location.city = @geodata.city
  end

  def location_params
    [@location.latitude, @location.longitude]
  end
end
