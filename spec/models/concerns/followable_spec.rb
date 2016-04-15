require 'rails_helper'

describe Followable, 'Followable' do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:story) { create(:story) }
  let(:another_story) { create(:story) }

  describe 'Associations' do
    subject { create(:user) }
    it { should have_many(:followings) }
  end

  describe '#followed?' do
    context 'following not exists' do
      it { expect(user.followed?(another_user)).to be_falsey }
      it { expect(user.followed?(another_story)).to be_falsey }
    end

    context 'following exists' do
      before do
        create(:following, user: user, followable: another_user)
        create(:following, user: user, followable: story)
      end

      it { expect(another_user.followings.exists?(user: user)).to be_truthy }
      it { expect(story.followings.exists?(user: user)).to be_truthy }
    end
  end

  describe '#followings_count' do
    context 'have no one followers' do
      it { expect(user.followings.count).to eq 0 }
      it { expect(another_story.followings_count).to eq 0 }
    end

    context 'have one follower' do
      before do
        create(:following, user: user, followable: another_user)
        create(:following, user: user, followable: story)
      end

      it { expect(another_user.followings.count).to eq 1 }
      it { expect(story.followings.count).to eq 1 }
    end
  end
end
