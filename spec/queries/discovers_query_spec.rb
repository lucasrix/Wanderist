require 'rails_helper'

describe DiscoversQuery do

  let(:origin_params) { ActionController::Parameters.new( {location: cities_list[:kyiv], radius: nil }) }

  subject { DiscoversQuery.new }

  before  do
    create_story_points_with_city
  end

  shared_examples 'sort_by_distance' do |method, radius|
    it 'sorts by distance' do
      result = create_query(method, radius)
      expect(city_by_distance).to eq(result)
    end
  end

  describe '#filter_by_city' do
    it 'filter story_points by city' do
      cities = create_query(:filter_by_city, radius: nil )
      expect(cities).to eq(['Kyiv'])
    end
  end

  describe '#filter_by_origin' do
    it 'filter data by origin' do
      cities = create_query(:filter_by_origin, radius: 1 )
      expect(cities).to eq(['Kyiv'])
    end

    it_behaves_like 'sort_by_distance', :filter_by_origin, radius: 10000
  end

  describe '#filter_whole_world' do
    it 'order descending by updated_at' do
      result = subject.send(:filter_whole_world)
      expect(result).to eq(StoryPoint.joins(:location).all.order(updated_at: :desc))
    end
  end

  def create_query(method, radius)
    current_location = origin_params.merge(radius)
    query = DiscoversQuery.new(current_location)
    result = query.send(method)
    result.map{|story_point| story_point.location.city}
  end
end
