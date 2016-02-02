class CreateSettingsSuits < ActiveRecord::Migration
  def change
    create_table :settings_suits do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :notifications, default: true
      t.boolean :autoupdate, default: true
      t.boolean :use_location, default: true
      t.boolean :public, default: false

      t.timestamps null: false
    end
  end
end
