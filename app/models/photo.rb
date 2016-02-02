class Photo < ActiveRecord::Base
  has_one :content, as: :entity
end
