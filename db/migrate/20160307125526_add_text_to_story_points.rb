class AddTextToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :text, :text
  end
end
