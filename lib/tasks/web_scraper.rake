namespace :web_scraper do
	task :immoscout => :environment do
		a = Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}

		pageNum = 0
		pageTotal = 0

		exposes = []

		while pageNum <= pageTotal
			pageNum = pageNum + 1

			a.get("https://www.immobilienscout24.de/Suche/S-T/P-#{pageNum}/Wohnung-Miete/Berlin/Berlin") do |page|

				pageTotal = page.search('[data-is24-qa="resultlist-resultCount"]').text.gsub(/\./mi, '').to_i / 20 if pageTotal == 0
				puts "Total pages: " + pageTotal.to_s
				puts "Page: " + pageNum.to_s

				page.search(".result-list__listing .result-list-entry__address a").each do |entry|
					expose_id = entry['data-result-id']

					puts "EXPOSE ID: " + expose_id

					marker = Marker.find_or_initialize_by(immoscout_id: expose_id)

					if marker.new_record?
						a.get 'https://www.immobilienscout24.de/expose/' + expose_id do |expose_page|

							company_name = expose_page.search('[data-qa="companyName"]').text
							address = expose_page.search('.address-block').last.text

							if !address.include?("Die vollständige Adresse der Immobilie erhalten Sie vom Anbieter.") && !company_name.blank?
								puts "ADRESSE: " + address
								puts "Company: " + company_name

								marker.address = address
								marker.companies << Company.find_or_initialize_by(name: company_name)
								marker.save
							end
						end
					end

					puts "---"
				end
			end


		end

	end
end
