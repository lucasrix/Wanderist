class AddColumnToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :blocked, :boolean, default: false
  end
end
