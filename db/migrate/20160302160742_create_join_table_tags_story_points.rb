class CreateJoinTableTagsStoryPoints < ActiveRecord::Migration
  def change
    create_join_table :tags, :story_points do |t|
      # t.index [:tag_id, :story_point_id]
      # t.index [:story_point_id, :tag_id]
    end
  end
end
