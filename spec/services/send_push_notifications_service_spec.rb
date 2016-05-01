require 'rails_helper'

describe SendPushNotificationsService do
  let(:story) { create(:story_with_story_points) }
  let(:story_point) { story.story_points.first }
  let(:user) { story.user }

  subject { SendPushNotificationsService.new(story, story_point) }

  describe '#call' do
    after do
      subject.call
    end

    context 'followed resource has followers' do
      it 'calls #build_push_notifications' do
        allow(subject).to receive(:tokens) { [ build(:gadget).token ] }
        expect(subject).to receive(:build_push_notifications)
      end
    end

    context 'followed resource hasnt followers' do
      it 'doesnt call #build_push_notifications' do
        allow(subject).to receive(:tokens).and_return([])
        expect(subject).not_to receive(:build_push_notifications)
      end
    end
  end

  describe '#build_push_notifications' do
    it 'calls .perform_later on PushNotificationJob' do
      service = PushNotificationJob
      allow(service).to receive(:perform_later)
      expect(service).to receive(:perform_later)
      subject.send(:build_push_notifications)
    end
  end

  describe '#tokens' do
    let(:another_user) { create(:user) }

    it 'returns array of tokens' do
      gadget = create(:gadget, user: another_user)
      create_list(:user, 5)
      create(:following, followable: story, user: another_user)
      tokens = subject.send(:tokens)
      expect(tokens).to match_array([gadget.token])
    end
  end

  describe '#message' do
    before do
      allow(subject).to receive(:get_message)
    end

    context 'followed is User' do
      it 'calls get_message with :new_resource' do
        subject.instance_variable_set(:@followed, user)
        expect(subject).to receive(:get_message).with(:new_resource)
        subject.send(:message)
      end
    end

    context 'followed is Story' do
      it 'calls get_message with :update_resource' do
        expect(subject).to receive(:get_message).with(:update_resource)
        subject.send(:message)
      end
    end
  end

  describe '#link' do
    before do
      allow(subject).to receive(:get_link)
    end

    context 'followed is User' do
      it 'calls get_link with Story' do
        subject.instance_variable_set(:@followed, user)
        subject.instance_variable_set(:@triggered, story)
        expect(subject).to receive(:get_link).with(story)
        subject.send(:link)
      end
    end

    context 'followed is Story' do
      it 'calls get_link with Story' do
        expect(subject).to receive(:get_link).with(story)
        subject.send(:link)
      end
    end
  end
end
