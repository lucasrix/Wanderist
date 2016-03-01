class StoryPointsService < BaseService
  def get_story_points
    StoryPoint.all
  end
end