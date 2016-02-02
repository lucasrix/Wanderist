class Text < ActiveRecord::Base
  has_one :content, as: :entity
  validates :text, presence: true
end
