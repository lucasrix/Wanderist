class StoryPointsService < BaseService
  def initialize(collection)
    @collection = collection.order(created_at: :desc)
  end

  def within_origin(latitude, longitude, radius)
    @collection.joins(:location).within(radius, origin: [latitude, longitude])
  end
end
