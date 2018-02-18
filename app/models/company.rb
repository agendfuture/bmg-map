class Company < ApplicationRecord

	has_many :companies_markers
	has_many :markers, through: :companies_markers

	def owned_by
		markers.where(companies_markers: { owner?: true })
	end

	def hired_out_to
		markers.where(companies_markers: { owner?: false })
	end
end
