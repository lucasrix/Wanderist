require 'rails_helper'

describe StoryPointsService do
  describe '#get_story_points' do
    it 'returns StoryPoint relation' do
      expect(subject.get_story_points).to be_a(StoryPoint::ActiveRecord_Relation)
    end
  end
end