class CreateStoryPoints < ActiveRecord::Migration
  def change
    create_table :story_points do |t|
      t.references :user, index: true, foreign_key: true
      t.string :caption
      t.references :story, index: true, foreign_key: true
    end
  end
end
