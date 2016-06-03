require 'rails_helper'

describe StoryPointSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:story_point) { create(:story_point) }
  let(:serializer) { StoryPointSerializer.new(story_point, scope: user) }

  describe 'attribute story_links' do
    context 'story_point hasnt stories' do
      it 'has empty story_links' do
        result = JSON.parse(serializer.to_json)['story_point']['story_links']
        expect(result).to match_array([])
      end
    end

    context 'story_point has stories' do
      it 'doesnt include key follower' do
        story_point.stories << story
        result = JSON.parse(serializer.to_json)['story_point']['story_links']
        expected_result = JSON.parse(StoryLinkSerializer.new(story).to_json)
        expect(result).to match_array([expected_result['story_link']])
      end
    end

    context 'story_point has stories reported by user' do
      it 'doesnt include reported stories' do
        reported_story = create(:story)
        create(:report, user: user, reportable: reported_story)
        story_point.stories << [story, reported_story]
        result = JSON.parse(serializer.to_json)['story_point']['story_links']
        expected_result = JSON.parse(StoryLinkSerializer.new(story, scope: user).to_json)
        expect(result).to match_array([expected_result['story_link']])
      end
    end
  end
end
