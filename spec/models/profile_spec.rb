require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:story) { create(:story) }

  context 'constants' do
    it { expect(Profile).to have_constant(:ABOUT_MAX_LENGTH) }
  end

  context 'validations' do
    it { should validate_length_of(:about).is_at_most(Profile::ABOUT_MAX_LENGTH) }
  end

  context 'relations' do
    it { should belong_to(:user) }
  end

  describe '#likes_count' do
    shared_examples 'likes_count' do
      it 'returns likes count' do
        create(:like, user: user, likable: story)
        expect(profile.likes_count).to eq(1)
      end
    end

    context 'only profile owner has liked resource' do
      it_behaves_like 'likes_count'
    end

    context 'another user has liked resource too' do
      before do
        create(:like, user: another_user, likable: story)
      end

      it_behaves_like 'likes_count'
    end
  end

  describe '#followings_count' do
    shared_examples 'followings_count' do
      it 'returns followings count' do
        create(:following, user: user, followable: story)
        expect(profile.followings_count).to eq(1)
      end
    end

    context 'only profile owner has followed resource' do
      it_behaves_like 'followings_count'
    end

    context 'another user has followed resource too' do
      before do
        create(:following, user: another_user, followable: story)
      end

      it_behaves_like 'followings_count'
    end
  end

  describe '#followers_count' do
    it 'returns followers count' do
      create(:following, user: create(:user), followable: user)
      expect(profile.followers_count).to eq(1)
    end
  end

  describe '#saves_count' do
    let(:story_points) { create_list(:story_point, 10) }

    shared_examples 'saves_count' do
      it 'returns count of story_points were saved by user' do
        story = create(:story, user: user)
        story.story_points << story_points
        expect(profile.saves_count).to eq(story_points.length)
      end
    end

    context 'user has saved story_points list to his story' do
      it_behaves_like 'saves_count'
    end

    context 'another user has saved story_points list to his story' do
      before do
        story = create(:story, user: another_user)
        story.story_points << story_points
      end

      it_behaves_like 'saves_count'
    end
  end

  describe '#story_points_count' do
    shared_examples 'story_points_count' do
      it 'returns count of story_points were created by user' do
        story_points_of_user = create_list(:story_point, 10, user: user)
        expect(profile.story_points_count).to eq(story_points_of_user.length)
      end
    end

    context 'user has created story_points' do
      it_behaves_like 'story_points_count'
    end

    context 'another user has created story_points too' do
      before  do
        create_list(:story_point, 10, user: another_user)
      end

      it_behaves_like 'story_points_count'
    end
  end
end
