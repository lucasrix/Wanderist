class AssignGeodataService < BaseService
  def initialize(location)
    @location = location
    @latitude = location.latitude
    @longitude = location.longitude
  end

  def call
    return if @location.new_record?
    load_geodata
    set_geodata
  end

  private

  def load_geodata
    geocode_service? ? get_geocode : get_reverse_geocode
    unless @geodata.success
      @location.errors.add(:geocode_error, I18n.t(:geocode_error, scope: [:locations, :errors]))
    end
  end

  def set_geodata
    return if @location.errors.any?
    if geocode_service?
      @latitude, @longitude = @geodata.lat, @geodata.lng
    else
      @location.city = @geodata.city
    end
  end

  def get_geocode
    @geodata = Geokit::Geocoders::GoogleGeocoder.geocode(@location.city)
  end

  def get_reverse_geocode
    @geodata = Geokit::Geocoders::GoogleGeocoder.reverse_geocode([@latitude, @longitude])
  end

  def geocode_service?
    @location.locatable.is_a?(Profile)
  end
end
