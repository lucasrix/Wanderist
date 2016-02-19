require 'rails_helper'

RSpec.describe User, type: :model do
  context 'relations' do
    it { should have_one(:profile) }
    it { is_expected.to have_one(:settings_suit) }
    it { is_expected.to have_many(:stories) }
    it { is_expected.to have_many(:story_points) }
    it { is_expected.to have_many(:story_relationships) }

    it do
      is_expected.to have_many(:followed_stories).through(:story_relationships)
        .source(:story)
    end

    it do
      is_expected.to have_many(:active_relationships)
        .class_name(UserRelationship.name).with_foreign_key('follower_id')
    end

    it do
      is_expected.to have_many(:passive_relationships)
        .class_name(UserRelationship.name).with_foreign_key('followed_id')
    end

    it do
      is_expected.to have_many(:following).through(:active_relationships)
        .source(:followed)
    end

    it do
      is_expected.to have_many(:followers).through(:passive_relationships)
        .source(:follower)
    end

    it { is_expected.to have_many(:likes) }

    it do
      is_expected.to have_many(:liked_story_points).through(:likes)
        .source(:story_point)
    end
  end

  context 'Validations' do
    subject { build(:user) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  end

  context 'callbacks' do
    it 'create profile' do
      user = create(:user)
      expect(user.profile).to be_a(Profile)
    end
  end
end