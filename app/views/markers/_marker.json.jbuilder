json.extract! marker, :id, :created_at, :updated_at, :lat, :lng, :name, :description, :address

if marker.companies.last
	 json.company marker.companies.last, partial: 'companies/company', as: :company
else
	json.company nil
end

json.url marker_url(marker)
