module Pushable
  extend ActiveSupport::Concern

  included do
    after_create { initialize_push_notifications }
  end

  def initialize_push_notifications(triggered = nil)
    followed = triggered.nil? ? user : self
    send_push_notifications(followed, triggered) if followed.followers.exists?
  end

  def send_push_notifications(followed, triggered = self)
    SendPushNotificationsService.call(followed, triggered)
  end
end
