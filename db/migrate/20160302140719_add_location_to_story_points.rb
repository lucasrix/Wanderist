class AddLocationToStoryPoints < ActiveRecord::Migration
  def change
    add_reference :story_points, :location, index: true, foreign_key: true
  end
end
