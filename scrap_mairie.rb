
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(s)
	page = Nokogiri::HTML(open(s))
	m = 0
	page.xpath('//td').each do |v|
		if v.text.include?("@")
			m = v.text
			break
		end
	end
	return m
end

def get_all_the_urls_of_val_doise_townhalls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	tab = []
	page.xpath('//a').each do |v|
		if v.to_s.include?("95")
			tab << { "name" => v.text.tr(' ', '_'), "email" => get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/" + v.to_s.delete_prefix!('<a class="lientxt" href="./').gsub(/html.*/, 'html')) }
		end
	end	
	return tab
end

puts get_all_the_urls_of_val_doise_townhalls
