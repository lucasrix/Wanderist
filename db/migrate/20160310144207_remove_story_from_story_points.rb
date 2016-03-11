class RemoveStoryFromStoryPoints < ActiveRecord::Migration
  def change
    remove_column :story_points, :story_id
  end
end
