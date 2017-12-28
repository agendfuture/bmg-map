class Marker < ApplicationRecord

	has_and_belongs_to_many :companies

	geocoded_by :address   # can also be an IP address
	after_validation :geocode

	reverse_geocoded_by :lat, :lng
	after_validation :reverse_geocode  # auto-fetch address
end
