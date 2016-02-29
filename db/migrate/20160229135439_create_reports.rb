class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :reportable, polymorphic: true, index: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
