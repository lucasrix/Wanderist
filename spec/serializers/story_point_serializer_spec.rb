require 'rails_helper'

describe StoryPointSerializer, :type => :serializer do
  let(:user) { build(:user) }
  let(:story) { build(:story) }
  let(:story_point) { build(:story_point) }

  describe 'attribute story_links' do
    context 'story_point hasnt stories' do
      let(:serializer) { StoryPointSerializer.new(story_point, scope: user) }

      it 'has empty story_links' do
        result = JSON.parse(serializer.to_json)['story_point']['story_links']
        expect(result).to match_array([])
      end
    end

    context 'story_point has stories' do
      let(:serializer) { StoryPointSerializer.new(story_point, scope: user) }

      it 'doesnt include key follower' do
        story_point.stories << story
        result = JSON.parse(serializer.to_json)['story_point']['story_links']
        expected_result = JSON.parse(StoryLinkSerializer.new(story).to_json)
        expect(result).to match_array([expected_result['story_link']])
      end
    end
  end
end

