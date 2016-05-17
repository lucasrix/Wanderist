require 'rails_helper'

describe SerializerFollowable, type: :serializer do
  let(:story) { build(:story) }
  let(:user) { build(:user) }

  describe '#filter' do
    context 'serialized is user' do
      let(:serializer) { UserSerializer.new(user, scope: user) }
      subject { JSON.parse(serializer.to_json)['user'] }

      it 'includes key follower' do
        expect(subject.keys).to include('follower')
      end
    end

    context 'serialized is story' do
      let(:serializer) { StorySerializer.new(story, scope: user) }
      subject { JSON.parse(serializer.to_json)['story'] }

      it 'doesnt include key follower' do
        expect(subject.keys).not_to include('follower')
      end
    end
  end
end
