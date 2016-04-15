class AddColumnStoryPointIdToStoryPoints < ActiveRecord::Migration
  def change
    add_column :locations, :story_point_id, :integer
  end
end
