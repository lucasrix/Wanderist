class BuildDiscoverService < BaseService
  def initialize(discover, page = nil)
    @discover = discover
    @page = page
  end

  def call
    load_stories
    delete_duplicates
    @discover = Kaminari.paginate_array(@discover).page(@page)
  end

  private

  def load_stories
    @discover = @discover.map { |story_point| discovered(story_point) }
  end

  def discovered(story_point)
    if story_point.stories.any?
      story_point.stories.sort_by(&:updated_at).reverse
    else
      story_point
    end
  end

  def delete_duplicates
    @discover.flatten!
    @discover.uniq! { |discovered| [discovered.id, discovered.class.name] }
  end
end
