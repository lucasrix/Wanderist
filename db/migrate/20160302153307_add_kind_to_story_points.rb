class AddKindToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :kind, :integer
  end
end
