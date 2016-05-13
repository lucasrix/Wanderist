class AddColumnKindToReports < ActiveRecord::Migration
  def change
    add_column :reports, :kind, :string
  end
end
