class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :url
      t.string :about

      t.timestamps null: false
    end
  end
end
