class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true

  validates :user_id, presence: true
end
