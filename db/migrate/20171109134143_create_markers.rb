class CreateMarkers < ActiveRecord::Migration[5.1]
  def change
    create_table :markers do |t|
    	t.float :lat
    	t.float :lng
    	t.string :name
    	t.text :description
      	t.timestamps
    end
  end
end
