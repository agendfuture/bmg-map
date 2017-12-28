json.extract! company, :id, :name, :description, :created_at, :updated_at
json.url company_url(company, format: :json)

json.markers company.markers do |marker|
	json.(marker, :id, :name, :address)
end