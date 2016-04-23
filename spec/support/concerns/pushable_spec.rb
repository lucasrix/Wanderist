require 'rails_helper'

shared_examples 'pushable' do
  let(:model) { described_class }
  subject { build(model) }

  describe '.after_create' do
    it 'calls #initialize_push_notifications' do
      expect(subject).to receive(:initialize_push_notifications)
      subject.save
    end
  end

  describe '#intialize_push_notifications' do
    before do
      allow_any_instance_of(User).to receive_message_chain(:followers, :exists?).and_return(true)
      allow_any_instance_of(Story).to receive_message_chain(:followers, :exists?).and_return(true)
      allow(subject).to receive(:send_push_notifications)
    end

    context 'triggered is nil' do
      it 'calls #send_push_notifications with pushable user' do
        expect(subject).to receive(:send_push_notifications) { subject.user }
        subject.initialize_push_notifications
      end
    end

    context 'triggered is StoryPoint' do
      let(:story_point) { build(:story_point) }
      subject { build(:story) }

      it 'calls #send_push_notifications with pushable and story_point' do
        expect(subject).to receive(:send_push_notifications).with(subject, story_point)
        subject.initialize_push_notifications(story_point)
      end
    end

    context 'pushable hasnt followers' do
      it 'doesnt call #send_push_notifications' do
        allow_any_instance_of(User).to receive_message_chain(:followers, :exists?).and_return(false)
        allow_any_instance_of(Story).to receive_message_chain(:followers, :exists?).and_return(false)
        expect(subject).not_to receive(:send_push_notifications)
        subject.initialize_push_notifications
      end
    end
  end

  describe '#send_push_notifications' do
    it 'calls .call on SendPushNotificationService' do
      allow(SendPushNotificationsService).to receive(:call)
      expect(SendPushNotificationsService).to receive(:call)
      subject.send_push_notifications(nil, nil)
    end
  end
end

