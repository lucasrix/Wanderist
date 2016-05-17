class CreateFollowerNotificationsService < BaseService
  def initialize(resource, event)
    @action_user = resource.user
    set_params(resource, event)
  end

  def call
    create_follower_notifications
  end

  private

  def set_params(resource, event)
    if resource.is_a?(Following)
      set_following_event_params(resource, event)
    else
      set_user_event_params(resource, event)
    end
  end

  def set_following_event_params(resource, _event)
    @target_resource = resource.followable
    @follower_ids = @target_resource.followers.ids
    @event = :new_following_story
  end

  def set_user_event_params(resource, event)
    @target_resource = resource
    @follower_ids = @action_user.followers.ids
    @event = event
  end

  def create_follower_notifications
    NotificationJob.perform_later(notification_params)
  end

  def notification_params
    {
      follower_ids: @follower_ids,
      notificable_id: @target_resource.id,
      notificable_type: @target_resource.class.name,
      action_user_id: @action_user.id,
      message: message
    }
  end

  def message
    I18n.t(@event, scope: :notifications)
  end
end
