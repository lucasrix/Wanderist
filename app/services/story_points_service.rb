class StoryPointsService < BaseService
  def initialize(collection)
    @collection = collection.order(created_at: :desc)
  end

  def within_origin(latitude, longitude, radius)
    origin = Location.new(latitude: latitude, longitude: longitude)
    locations = Location.within(radius, origin: origin)

    @collection.where(location: locations)
  end

end
