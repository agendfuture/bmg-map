class AddOwnerFlagCompaniesMarker < ActiveRecord::Migration[5.1]
  def change

  	add_column :companies_markers, :owner?, :bool, default: false
  end
end
