require 'rails_helper'

describe CreateFollowerNotificationsService do
  let(:story) { create(:story_with_story_points) }
  let(:event) { Notificable::FOLLOWER_NOTIFICATIONS.sample }

  subject { CreateFollowerNotificationsService.new(story, event) }

  describe '#initialize' do
    it 'sets @action_user to resource.user' do
      action_user = subject.instance_variable_get(:@action_user)
      expect(action_user).to eq(story.user)
    end

    it 'calls #set_params' do
      allow(subject).to receive(:set_params)
      expect(subject).to receive(:set_params)
      subject.send(:initialize, story, event)
    end
  end

  describe '#call' do
    it 'calls #create_follower_notifications' do
      allow(subject).to receive(:create_follower_notifications)
      expect(subject).to receive(:create_follower_notifications)
      subject.call
    end
  end

  describe '#set_params' do
    let(:another_user) { create(:user) }

    context 'resource is following' do
      let(:resource) { create(:following, followable: story, user: another_user) }

      before do
        subject.send(:set_params, resource, :new_following)
      end

      it 'sets @target_resource to followable' do
        target_resource = subject.instance_variable_get(:@target_resource)
        expect(target_resource).to eq(resource.followable)
      end

      it 'sets @follower_ids to ids of resource followers' do
        follower_ids = subject.instance_variable_get(:@follower_ids)
        expected_follower_ids = resource.followable.followers.ids
        expect(follower_ids).to eq(expected_follower_ids)
      end

      it 'sets @event to :new_following_story' do
        event = subject.instance_variable_get(:@event)
        expect(event).to eq(:new_following_story)
      end
    end

    context 'resource isnt following' do
      let(:resource) { create(:story, user: another_user) }

      before do
        subject.send(:set_params, resource, :new_story)
      end

      it 'sets @target_resource to resource' do
        target_resource = subject.instance_variable_get(:@target_resource)
        expect(target_resource).to eq(resource)
      end

      it 'sets @follower_ids user followers ids' do
        follower_ids = subject.instance_variable_get(:@follower_ids)
        action_user = subject.instance_variable_get(:@action_user)
        expected_follower_ids = action_user.followers.ids
        expect(follower_ids).to eq(expected_follower_ids)
      end

      it 'sets @event to :new_story' do
        event = subject.instance_variable_get(:@event)
        expect(event).to eq(:new_story)
      end
    end
  end

  describe '#create_follower_notifications' do
    before do
      allow(NotificationJob).to receive(:perform_later)
      allow(subject).to receive(:notification_params)
    end

    after do
      subject.send(:create_follower_notifications)
    end

    it 'calls #notification_params' do
      expect(subject).to receive(:notification_params)
    end

    it 'calls #perform_later on NotificationJob' do
      expect(NotificationJob).to receive(:perform_later)
    end
  end

  describe '#message' do
    it 'returns notifications message' do
      message = subject.send(:message)
      expect(message).to eq(I18n.t(event, scope: :notifications))
    end
  end
end
