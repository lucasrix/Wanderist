class SendPushNotificationsService < BaseService
  def initialize(followed, triggered)
    @followed = followed
    @triggered = triggered
  end

  def call
    build_push_notifications if tokens.any?
  end

  private

  def build_push_notifications
    PushNotificationJob.perform_later(tokens, message, link)
  end

  def tokens
    Gadget.where(user: @followed.followers).pluck(:token)
  end

  def message
    @followed.is_a?(User) ? get_message(:new_resource) : get_message(:update_resource)
  end

  def get_message(event)
    I18n.t(
      event,
      scope: :push_notifications,
      followed: @followed.class.name,
      triggered: @triggered.class.name
    )
  end

  def link
    @followed.is_a?(User) ? get_link(@triggered) : get_link(@followed)
  end

  def get_link(resource)
    "maplify://#{resource.class.name.underscore.pluralize}/#{resource.id}"
  end
end
