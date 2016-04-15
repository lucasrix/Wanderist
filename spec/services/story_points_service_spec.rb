require 'rails_helper'

describe StoryPointsService do
  let(:collection) { StoryPoint.all }
  subject { StoryPointsService.new(collection) }

  describe '#initialize' do
    it 'creates @collection' do
      expect(subject.instance_variable_get(:@collection)).to match_array(collection)
    end

    it 'order descending by created_at' do
      old_story_point = create(:story_point, created_at: 2.hours.ago)
      new_story_point = create(:story_point, created_at: 1.hour.ago)
      expect(subject.instance_variable_get(:@collection).to_a).to eq([new_story_point, old_story_point])
    end
  end

  describe '#within_origin' do
    it 'returns StoryPoint relation' do
      expect(subject.within_origin(1, 1, 1)).to be_a(StoryPoint::ActiveRecord_Relation)
    end
  end
end
