json.array! @markers do |marker|
	json.extract! marker, :id, :created_at, :updated_at, :lat, :lng, :name, :description, :address

	if marker.companies.last
		 json.company(marker.companies.last, :id, :name)
	else
		json.company nil
	end
end