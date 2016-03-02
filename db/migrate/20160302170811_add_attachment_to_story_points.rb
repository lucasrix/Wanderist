class AddAttachmentToStoryPoints < ActiveRecord::Migration
  def change
    add_reference :story_points, :attachment, index: true, foreign_key: true
  end
end
