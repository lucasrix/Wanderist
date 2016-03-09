require 'rails_helper'

describe LocationsService do
  subject { LocationsService.new }

  describe '#initialize' do
    it 'creates @collection' do
      expect(subject.instance_variable_get(:@collection)).not_to be_empty
    end
  end

  describe '#within_origin' do
    it 'returns location relation' do
      expect(subject.within_origin(1, 1, 1)).to be_a(Location::ActiveRecord_Relation)
    end

  end

end