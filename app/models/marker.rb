class Marker < ApplicationRecord

	has_many :companies_markers
	has_many :companies, through: :companies_markers

	accepts_nested_attributes_for :companies_markers

	geocoded_by :address   # can also be an IP address
	after_validation :geocode

	reverse_geocoded_by :lat, :lng
	after_validation :reverse_geocode  # auto-fetch address

	def owners
		companies.where(companies_markers: { owner?: true })
	end

	def landlords
		companies.where(companies_markers: { owner?: false })
	end
end
