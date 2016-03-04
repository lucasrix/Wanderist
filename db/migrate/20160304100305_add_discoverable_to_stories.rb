class AddDiscoverableToStories < ActiveRecord::Migration
  def change
    add_column :stories, :discoverable, :boolean, default: true
  end
end
