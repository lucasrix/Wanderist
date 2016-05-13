class NotificationSerializer < ApplicationSerializer
  attributes :id, :message, :unread, :updated_at, :created_at, :notificable_type
  has_one :notificable
  has_one :action_user
end
