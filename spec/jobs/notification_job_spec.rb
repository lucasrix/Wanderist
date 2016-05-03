require 'rails_helper'

RSpec.describe NotificationJob, type: :job do
  let(:follower_ids) { (1..10).to_a }
  let(:notificable) { create(:story) }
  let :params do
    {
      follower_ids: follower_ids,
      notificable_id: notificable.id,
      notificable_type: notificable.class.name,
      action_user_id: rand(1..10),
      message: Notificable::FOLLOWER_NOTIFICATIONS.sample
    }
  end

  it 'creates notifications for followers' do
    allow(Notification).to receive(:create)
    expect(Notification).to receive(:create).exactly(follower_ids.length).times
    NotificationJob.perform_now(params)
  end
end
