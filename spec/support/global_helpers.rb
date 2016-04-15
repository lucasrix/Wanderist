require 'rails_helper'
module GlobalHelpers
  def cities_list
    {
      london:   { latitude: 51.30, longitude: 0.07,  city: 'London' },
      warsaw:   { latitude: 52.13, longitude: 21.00, city: 'Warsaw' },
      kyiv:     { latitude: 50.27, longitude: 30.31, city: 'Kyiv' },
      new_york: { latitude: 40.42, longitude: 74.00, city: 'New York' }
    }
  end

  def create_story_points_with_city
    cities_list.each { |_name, params| create(:story_point).location = create(:location, params) }
  end

  def city_by_distance
    ['Kyiv', 'Warsaw', 'London', 'New York']
  end
end
