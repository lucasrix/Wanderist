class DiscoversQuery < BaseQuery
  CITY_CENTER_RADIUS = 1

  def initialize(origin_params = nil, relation = StoryPoint)
    @origin_params = origin_params || {}
    @relation = relation.includes(:stories).joins(:location)
    build_origin if @origin_params[:location].present?
  end

  def load_relation
    case
    when @radius && @origin
      filter_by_origin
    when @origin
      filter_by_city + story_points_outside_city
    else
      filter_whole_world
    end
  end

  private

  def build_origin
    @radius = @origin_params[:radius]
    @origin = Location.new(location_params)
    @city = Location.within(CITY_CENTER_RADIUS, origin: @origin)
                    .where.not(locatable_type: 'Profile')
                    .first.try(:city)
  end

  def filter_by_origin
    @relation.within(@radius, origin: @origin).by_distance(origin: @origin)
  end

  def filter_by_city
    @relation.where('locations.city = ?', @city.to_s).order(updated_at: :desc)
  end

  def story_points_outside_city
    @relation.by_distance(origin: @origin)
             .where('locations.city != ? OR locations.city IS ?', @city.to_s, nil)
  end

  def filter_whole_world
    @relation.order(updated_at: :desc)
  end

  def location_params
    @origin_params.require(:location).permit(:latitude, :longitude)
  end
end
