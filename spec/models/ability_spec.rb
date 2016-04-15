require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  subject { Ability.new(user) }

  context 'story points' do
    let(:story_point) { build(:story_point, user: user) }
    let(:foreign_story_point) { build(:story_point, user: another_user) }

    describe 'create' do
      it { should be_able_to(:create, story_point) }
      it { should_not be_able_to(:create, foreign_story_point) }
    end

    describe 'update' do
      it { should be_able_to(:update, story_point) }
      it { should_not be_able_to(:update, foreign_story_point) }
    end

    describe 'read' do
      it { should be_able_to(:read, story_point) }
      it { should be_able_to(:read, foreign_story_point) }
    end

    describe 'destroy' do
      it { should be_able_to(:destroy, story_point) }
      it { should_not be_able_to(:destroy, foreign_story_point) }
    end
  end

  context 'attachment' do
    let(:attachment) { build(:attachment, user: user) }
    let(:foreign_attachment) { build(:attachment, user: another_user) }

    describe 'read' do
      it { should be_able_to(:read, attachment) }
      it { should_not be_able_to(:read, foreign_attachment) }
    end

    describe 'create' do
      it { should be_able_to(:create, attachment) }
      it { should_not be_able_to(:create, foreign_attachment) }
    end
  end

  context 'story' do
    let(:story) { build(:story, user: user) }
    let(:foreign_story) { build(:story, user: another_user) }

    describe 'read' do
      it { should be_able_to(:read, story) }
      it { should be_able_to(:read, foreign_story) }
    end

    describe 'create' do
      it { should be_able_to(:create, story) }
      it { should_not be_able_to(:create, foreign_story) }
    end

    describe 'update' do
      it { should be_able_to(:update, story) }
      it { should_not be_able_to(:update, foreign_story) }
    end

    describe 'destroy' do
      it { should be_able_to(:destroy, story) }
      it { should_not be_able_to(:destroy, foreign_story) }
    end
  end

  context 'profile' do
    let(:profile) { build(:profile, user: user) }
    let(:foreign_profile) { build(:profile, user: another_user) }

    describe 'read' do
      it { should be_able_to(:read, profile) }
      it { should be_able_to(:read, foreign_profile) }
    end

    describe 'update' do
      it { should be_able_to(:update, profile) }
      it { should_not be_able_to(:update, foreign_profile) }
    end
  end

  context 'location' do
    let(:location) { build(:location) }

    it { should be_able_to(:cities, location) }
  end

  context 'likes' do
    context 'story point' do
      let(:story_point) { build(:story_point, user: another_user) }
      let(:like) { build(:like, user: user, likable: story_point) }
      let(:like_without_user) { build(:like, user: nil, likable: story_point) }

      describe 'create' do
        it { should be_able_to(:create, like) }
        it { should_not be_able_to(:create, like_without_user) }
      end

      describe 'destroy' do
        let(:like_another_user) { build(:like, user: another_user, likable: story_point) }
        it { should be_able_to(:destroy, like) }
        it { should_not be_able_to(:destroy, like_another_user) }
      end
    end

    context 'story' do
      let(:story) { build(:story, user: another_user) }
      let(:like) { build(:like, user: user, likable: story) }
      let(:like_without_user) { build(:like, user: nil, likable: story) }

      describe 'create' do
        it { should be_able_to(:create, like) }
        it { should_not be_able_to(:create, like_without_user) }
      end

      describe 'destroy' do
        let(:like_another_user) { build(:like, user: another_user, likable: story) }
        it { should be_able_to(:destroy, like) }
        it { should_not be_able_to(:destroy, like_another_user) }
      end
    end
  end

  context 'followings' do
    context 'story' do
      let(:story) { build(:story, user: another_user) }
      let(:following) { build(:following, user: user, followable: story) }
      let(:following_without_user) { build(:following, user: nil, followable: story) }

      describe 'create' do
        it { should be_able_to(:create, following) }
        it { should_not be_able_to(:create, following_without_user) }
      end

      describe 'destroy' do
        it { should be_able_to(:destroy, following) }
        it { should_not be_able_to(:destroy, following_without_user) }
      end
    end

    context 'user' do
      let(:following) { build(:following, user: user, followable: another_user) }
      let(:following_without_user) { build(:following, user: nil, followable: another_user) }
      let(:following_by_himself) { build(:following, user: user, followable: user) }

      describe 'create' do
        it { should be_able_to(:create, following) }
        it { should_not be_able_to(:create, following_without_user) }
        it { should_not be_able_to(:create, following_by_himself) }
      end

      describe 'destroy' do
        it { should be_able_to(:destroy, following) }
        it { should_not be_able_to(:destroy, following_without_user) }
      end
    end
  end

  context 'user' do
    describe 'read' do
      it { should be_able_to(:read, user) }
      it { should be_able_to(:read, another_user) }
    end
  end
end
