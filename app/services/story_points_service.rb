class StoryPointsService < BaseService
  def initialize(collection)
    @collection = collection
  end

  def get_story_points
    locations = LocationsService.new
    locations = locations.within_origin(48.4640, 35.0538, 1)
    @collection.where(location: locations)
  end

end