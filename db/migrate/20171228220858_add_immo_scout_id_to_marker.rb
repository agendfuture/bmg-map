class AddImmoScoutIdToMarker < ActiveRecord::Migration[5.1]
  def change
    add_column :markers, :immoscout_id, :integer
  end
end
