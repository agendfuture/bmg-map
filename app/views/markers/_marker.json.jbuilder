json.extract! marker, :id, :created_at, :updated_at, :lat, :lng, :name, :description
json.company marker.companies.last, partial: 'companies/company', as: :company

json.url marker_url(marker)
