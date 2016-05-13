class CreateOwnerNotificationsService < BaseService

  def initialize(resource, event)
    @action_user = resource.user
    @target_resource = resource.is_a?(Like) ? resource.likable : resource.followable
    @owner = @target_resource.try(:user) || @target_resource
    @event = event
  end

  def call
    create_owner_notification
  end

  private

  def create_owner_notification
    @owner.notifications.create(notification_params)
  end

  def notification_params
    {
      notificable: @target_resource,
      action_user: @action_user,
      message: message,
    }
  end

  def message
    I18n.t(
            @event,
            scope: :notifications,
            resource: @target_resource.class.name
          )
  end
end
