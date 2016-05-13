module Notificable
  extend ActiveSupport::Concern

  OWNER_NOTIFICATIONS = %i(new_following new_like new_follower)
  FOLLOWER_NOTIFICATIONS = %i(new_following new_story new_story_point new_story_point_in_story)

  included do
    after_create { initialize_notifications }
  end

  def initialize_notifications(triggered = nil)
    event = get_event(triggered)
    create_owner_notifications(self, event) if OWNER_NOTIFICATIONS.include?(event)
    create_follower_notifications(self, event) if FOLLOWER_NOTIFICATIONS.include?(event)
  end

  def get_event(triggered)
   case
   when triggered
     :new_story_point_in_story
   when is_a?(Story)
     :new_story
   when is_a?(StoryPoint)
     :new_story_point
   when is_a?(Like)
     :new_like
   when is_a?(Following) && followable.is_a?(User)
     :new_follower
   when is_a?(Following)
     :new_following
   end
  end

  def create_owner_notifications(resource, event)
    CreateOwnerNotificationsService.call(resource, event)
  end

  def create_follower_notifications(resource, event)
    CreateFollowerNotificationsService.call(resource, event)
  end
end
