class CreateJoinTableStoryPointsStories < ActiveRecord::Migration
  def change
    create_join_table :story_points, :stories do |t|
      # t.index [:story_point_id, :story_id]
      # t.index [:story_id, :story_point_id]
    end
  end
end
