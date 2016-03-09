require 'rails_helper'

describe StoryPointsService do
  let(:collection) { StoryPoint.all }
  subject { StoryPointsService.new(collection) }

  describe '#initialize' do
    it 'creates @collection' do
      expect(subject.instance_variable_get(:@collection)).to eq collection
    end
  end

  describe '#get_story_points' do
    it 'returns StoryPoint relation' do
      expect(subject.get_story_points).to be_a(StoryPoint::ActiveRecord_Relation)
    end

  end


end