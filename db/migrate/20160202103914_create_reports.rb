class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true
      t.references :reportable, polymorphic: true, index: true
      t.string :kind
      t.text :message

      t.timestamps null: false
    end
  end
end
