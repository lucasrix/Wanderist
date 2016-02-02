class Content < ActiveRecord::Base
  belongs_to :story_point
  belongs_to :entity, polymorphic: true
end
