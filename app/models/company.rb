class Company < ApplicationRecord

	has_many :companies_markers
	has_many :markers, through: :companies_markers

	def owned_by
		markers.where(companies_markers: { owner?: true })
	end

	def hired_out_to
		markers.where(companies_markers: { owner?: false })
	end

	def self.remove_duplicates
		Company.group("lower(companies.name)").having("count(lower(companies.name))>1").count
		#.select("COUNT(*) AS count_all, lower(companies.name) AS lower_companies_name, array_agg(companies.name) AS company_ids")
	end
end
