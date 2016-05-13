class AddTokenToReports < ActiveRecord::Migration
  def change
    add_column :reports, :action_token, :string
  end
end
