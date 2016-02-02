class CreateSettingsSuits < ActiveRecord::Migration
  def change
    create_table :settings_suits do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :notifications
      t.boolean :autoupdate
      t.boolean :use_location
      t.boolean :public

      t.timestamps null: false
    end
  end
end
