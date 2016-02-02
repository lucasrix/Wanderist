class CreateStoryPoints < ActiveRecord::Migration
  def change
    create_table :story_points do |t|
      t.references :user, index: true, foreign_key: true
      t.references :story, index: true, foreign_key: true
      t.string :caption
      t.string :location
      t.string :latitude
      t.string :longitude
      t.boolean :public, default: false

      t.timestamps null: false
    end
  end
end
