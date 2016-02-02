class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :story_point, index: true, foreign_key: true
      t.references :entity, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
