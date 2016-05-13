class Like < ActiveRecord::Base
  include Notificable

  belongs_to :user
  belongs_to :likable, polymorphic: true
  validates_uniqueness_of :user_id, scope: [:likable_id, :likable_type]
end
