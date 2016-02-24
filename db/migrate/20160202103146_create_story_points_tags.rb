class CreateStoryPointsTags < ActiveRecord::Migration
  def change
    create_table :story_points_tags, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :story_point, index: true
    end
  end
end
