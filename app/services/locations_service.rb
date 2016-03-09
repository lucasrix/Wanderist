class LocationsService < BaseService
  def initialize
    @collection = Location.all
  end

  def within_origin(latitude, longitude, radius)
    origin = Location.new(latitude: latitude, longitude: longitude)

    @collection.within(radius, origin: origin)
  end
end
