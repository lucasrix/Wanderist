class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :taggable, polymorphic: true, index: true
      t.string :name
      t.integer :author
    end
  end
end
