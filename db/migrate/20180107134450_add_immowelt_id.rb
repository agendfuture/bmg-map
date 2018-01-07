class AddImmoweltId < ActiveRecord::Migration[5.1]
  def change

  	add_column :markers, :immowelt_id, :string
  end
end
