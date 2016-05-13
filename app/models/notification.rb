class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :action_user, class_name: User.name, foreign_key: 'action_user_id'
  belongs_to :notificable, polymorphic: true
  validates :message, :user_id, :notificable_id, :notificable_type, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
