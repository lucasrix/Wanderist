class AddAttachmentToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :attachment, :string
  end
end
