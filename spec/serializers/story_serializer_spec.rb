require 'rails_helper'

describe StorySerializer, type: :serializer do
  context 'story has story_points reported by user' do
    it 'doesnt include reported story_points' do
      user = create(:user)
      story = create(:story)
      story_point = create(:story_point)
      reported_story_point = create(:story_point)
      create(:report, user: user, reportable: reported_story_point)
      serializer = StorySerializer.new(story, scope: user)
      story.story_points << [story_point, reported_story_point]
      result = JSON.parse(serializer.to_json)['story']['story_points']
      expected_result = JSON.parse(StoryPointSerializer.new(story_point, scope: user).to_json)
      expect(result).to match_array([expected_result['story_point']])
    end
  end
end
