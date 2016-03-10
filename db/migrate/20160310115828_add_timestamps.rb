class AddTimestamps < ActiveRecord::Migration
  def change
    add_timestamps :stories, null: false
    add_timestamps :story_points, null: false
    add_timestamps :tags, null: false
    add_timestamps :profiles, null: false
    add_timestamps :likes, null: false
    add_timestamps :reports, null: false
    add_timestamps :story_points_tags, null: false
  end
end
