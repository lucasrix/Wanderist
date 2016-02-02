class Photo < ActiveRecord::Base
  has_one :content, as: :entity
  validates :file, presence: true
end
