require 'rails_helper'

describe CreateOwnerNotificationsService do
  let(:story) { create(:story) }
  let(:following) { create(:following, followable: story) }
  let(:like) { create(:like, likable: story) }
  let(:event) { Notificable::OWNER_NOTIFICATIONS.sample }

  subject { CreateOwnerNotificationsService.new(following, event) }

  describe '#initialize' do
    it 'sets @action_user to resource.user' do
      action_user = subject.instance_variable_get(:@action_user)
      expect(action_user).to eq(following.user)
    end

    context 'resource is Following' do
      it 'sets @target_resource to followable' do
        target_resource = subject.instance_variable_get(:@target_resource)
        expect(target_resource).to eq(following.followable)
      end
    end

    context 'resource is Like' do
      subject { CreateOwnerNotificationsService.new(like, event) }

      it 'sets @target_resource to likeable' do
        target_resource = subject.instance_variable_get(:@target_resource)
        expect(target_resource).to eq(like.likable)
      end
    end

    context '@target_resource is user' do
      it 'sets @owner to @target_resource' do
        following = Following.new(user: create(:user), followable: story.user)
        service = CreateOwnerNotificationsService.new(following, event)
        target_resource = service.instance_variable_get(:@target_resource)
        owner = service.instance_variable_get(:@owner)
        expect(owner).to eq(target_resource)
      end
    end

    context '@target_resource isnt user' do
      it 'sets @owner to @target_resource' do
        target_resource = subject.instance_variable_get(:@target_resource)
        owner = subject.instance_variable_get(:@owner)
        expect(owner).to eq(target_resource.user)
      end
    end
  end

  describe '#call' do
    it 'calls #create_owner_notifications' do
      allow(subject).to receive(:create_owner_notification)
      expect(subject).to receive(:create_owner_notification)
      subject.call
    end
  end

  describe '#create_owner_notification' do
    it 'creates new notification' do
      subject.send(:create_owner_notification)
      expect { subject.send(:create_owner_notification) }.to change { Notification.count }.by(1)
    end
  end
end
