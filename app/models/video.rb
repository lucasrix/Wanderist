class Video < ActiveRecord::Base
  has_one :content, as: :entity
end
