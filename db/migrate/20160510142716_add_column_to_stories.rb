class AddColumnToStories < ActiveRecord::Migration
  def change
    add_column :stories, :blocked, :boolean, default: false
  end
end
