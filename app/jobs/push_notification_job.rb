class PushNotificationJob < ActiveJob::Base
  DEFAULT_BADGE_COUNT = 1

  queue_as :push_notifications

  def perform(tokens, message, link)
    tokens.each do |token|
      notification = Houston::Notification.new(device: token)
      notification.alert = message
      notification.sound = 'default'
      notification.badge = DEFAULT_BADGE_COUNT
      notification.custom_data = { link: link }
      APN.push(notification)
    end
  end
end
