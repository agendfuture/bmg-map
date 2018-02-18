class AddHistoryToCompanyMarkerJoinTable < ActiveRecord::Migration[5.1]
  def change
  	change_table :companies_markers do |t|
	    t.datetime :changed_responsibility_at
  	end
  end
end
