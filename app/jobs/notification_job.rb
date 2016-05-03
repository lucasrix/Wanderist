class NotificationJob < ActiveJob::Base

  queue_as :notifications

  def perform(follower_ids: , notificable_id: , notificable_type: , action_user_id: , message: )
    notificable = notificable_type.constantize.find(notificable_id)
    follower_ids.each do |user_id|
      Notification.create(user_id: user_id,
                          notificable: notificable,
                          action_user_id: action_user_id,
                          message: message)
    end
  end
end
