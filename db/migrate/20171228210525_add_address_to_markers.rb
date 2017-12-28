class AddAddressToMarkers < ActiveRecord::Migration[5.1]
  def change
  	add_column :markers, :address, :string
  end
end
