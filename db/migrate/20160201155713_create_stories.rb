class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.boolean :public, default: false
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
