class AddRelationBetweenMarkersAndCompanies < ActiveRecord::Migration[5.1]
  def change

  	create_table :companies_markers do |t|
  		t.references :marker
  		t.references :company
  	end
  end
end
