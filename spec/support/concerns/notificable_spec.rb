require 'rails_helper'

shared_examples 'notificable' do
  let(:model) { described_class }
  subject { build(model) }

  before do
    allow(CreateOwnerNotificationsService).to receive(:call)
    allow(CreateFollowerNotificationsService).to receive(:call)
  end

  describe '.after_create' do
    it 'calls #initialize_notifications' do
      expect(subject).to receive(:initialize_notifications)
      subject.save
    end
  end

  describe '#intialize_notifications' do
    context 'owner notification event' do
      it 'calls #create_owner_notifications' do
        allow(subject).to receive(:get_event).and_return(Notificable::OWNER_NOTIFICATIONS.sample)
        expect(subject).to receive(:create_owner_notifications)
        subject.initialize_notifications
      end
    end

    context 'follower notification event' do
      it 'calls #create_follower_notifications' do
        allow(subject).to receive(:get_event).and_return(Notificable::FOLLOWER_NOTIFICATIONS.sample)
        expect(subject).to receive(:create_follower_notifications)
        subject.initialize_notifications
      end
    end

    it 'calls #get_event' do
      allow(subject).to receive(:get_event)
      expect(subject).to receive(:get_event)
      subject.initialize_notifications
    end
  end

  describe '#get_event' do
    context 'subject has triggered' do
      it 'returns :new_story_point_in_story' do
        object = build(:story)
        result = object.get_event(StoryPoint.new)
        expect(result).to eq(:new_story_point_in_story)
      end
    end

    context 'subject is Story' do
      it 'returns :new_story' do
        object = build(:story)
        result = object.get_event(nil)
        expect(result).to eq(:new_story)
      end
    end

    context 'subject is StoryPoint' do
      it 'returns :new_story_point' do
        object = build(:story_point)
        result = object.get_event(nil)
        expect(result).to eq(:new_story_point)
      end
    end

    context 'subject is Like' do
      it 'returns :new_story_point' do
        object = build(:like)
        result = object.get_event(nil)
        expect(result).to eq(:new_like)
      end
    end

    context 'subject is Following' do
      context 'followable is user' do
        it 'returns :new_follower' do
          object = build(:following, followable: build(:user))
          result = object.get_event(nil)
          expect(result).to eq(:new_follower)
        end
      end

      context 'followable is story' do
        it 'returns :new_following' do
          object = build(:following, followable: build(:story))
          result = object.get_event(nil)
          expect(result).to eq(:new_following)
        end
      end
    end
  end

  describe '#create_owner_notifications' do
    it 'calls .call on CreateOwnerNotificationsService' do
      expect(CreateOwnerNotificationsService).to receive(:call)
      subject.create_owner_notifications(nil, nil)
    end
  end

  describe '#create_follower_notifications' do
    it 'calls .call on CreateFollowerNotificationsService' do
      expect(CreateFollowerNotificationsService).to receive(:call)
      subject.create_follower_notifications(nil, nil)
    end
  end
end

