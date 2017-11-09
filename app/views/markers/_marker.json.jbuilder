json.extract! marker, :id, :created_at, :updated_at, :lat, :lng, :name, :description
json.company marker.companies.last.try(:name)
json.url marker_url(marker)
