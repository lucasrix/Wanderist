class DeleteStoryPointIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :story_point_id
  end
end
