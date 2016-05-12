class NotificationJob < ActiveJob::Base

  queue_as :notifications

  def perform(follower_ids: , notificable_id: , notificable_type: , action_user_id: , message: )
    return unless notificable_type.constantize.exists?(id: notificable_id)
    follower_ids.each do |user_id|
      Notification.create(user_id: user_id,
                          notificable_id: notificable_id,
                          notificable_type: notificable_type,
                          action_user_id: action_user_id,
                          message: message)
    end
  end
end
