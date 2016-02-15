class CreateStoryPoints < ActiveRecord::Migration
  def change
    create_table :story_points do |t|
      t.references :user, index: true, foreign_key: true
      t.string :file
      t.text   :text
      t.string :caption
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :kind
      t.boolean :public, default: true

      t.timestamps null: false
    end

    create_table :stories_story_points, id: false do |t|
      t.belongs_to :story, index: true
      t.belongs_to :story_point, index: true
    end
  end
end
