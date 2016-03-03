class AddPrivateToStories < ActiveRecord::Migration
  def change
    add_column :stories, :private, :boolean, default: false
  end
end
