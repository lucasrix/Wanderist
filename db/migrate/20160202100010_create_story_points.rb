class CreateStoryPoints < ActiveRecord::Migration
  def change
    create_table :story_points do |t|
      t.string :caption
      t.string :location
      t.string :latitude
      t.string :longitude
      t.boolean :public

      t.timestamps null: false
    end
  end
end
