class Audio < ActiveRecord::Base
  has_one :content, as: :entity
end
