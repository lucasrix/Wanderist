class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :action_user_id
      t.boolean :unread, default: true
      t.integer :notificable_id
      t.string :notificable_type
      t.string :message

      t.timestamps null: false
    end
  end
end
