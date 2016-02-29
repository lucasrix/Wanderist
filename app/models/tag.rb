class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true

  validates :name, presence: true
end
