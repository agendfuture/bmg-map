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

	task :immowelt => :environment do
		a = Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}

		pageNum = 0
		pageTotal = 0

		exposes = []

		while pageNum <= pageTotal
			pageNum = pageNum + 1

			a.get("https://www.immowelt.de/liste/berlin/wohnungen/mieten?cp=#{pageNum}") do |page|

				pageTotal = page.search('.js-btnResultCount').first.text.gsub(/\./mi, '').to_i / 20 if pageTotal == 0
				puts "Total pages: " + pageTotal.to_s
				puts "Page: " + pageNum.to_s

				page.search("[data-oid]").each do |entry|
					expose_id = entry['data-oid']

					puts "EXPOSE ID: " + expose_id

				 	marker = Marker.find_or_initialize_by(immowelt_id: expose_id)

					if marker.new_record?
						a.get 'https://www.immowelt.de/expose/' + expose_id do |expose_page|

							company_name = nil
							if first = expose_page.search('#divAnbieter > div > div > div.section_wrapper.iw_left > div > div:nth-child(2) > div > div > div.grid_06o12_l.grid_06o12_m.grid_12o12_s.order_2_s.padding_bottom_none > strong > a').try(:first)
								a.get(first['href']) do |company_page|
									company_name = company_page.search('#basecontainer > div.anbieterprofil > div.anbieter_info_box > div > div > div > div.content_box.iw_relative > div:nth-child(1) > h1').text
								end
							end

							address = expose_page.search('#divLageinfos > div.section.no_grid_padding > div > div > div > div:nth-child(2) > div.section_content.iw_right > p').last.text

							if !address.include?("Die vollständige Adresse der Immobilie erhalten Sie vom Anbieter.") && address.lines.count == 4 && !company_name.blank?
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
