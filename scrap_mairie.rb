
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(s)
	page = Nokogiri::HTML(open(s))
	t = []
	m = 0
	t = page.css('td')
	t.each do |v|
		if v.text.include?("@")
			m = v.text
			break
		end
	end
	return m
end

def get_all_the_urls_of_val_doise_townhalls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	t = []
	t = page.css('a')
	m = []
	n = []
	t.each do |v|
		if v.to_s.include?("95")
			m << "http://annuaire-des-mairies.com/" + v.to_s.delete_prefix!('<a class="lientxt" href="./').gsub(/html.*/, 'html')
			n << v.text.tr(' ', '_')
		end
	end	
	return n,m
end

def union
	t = get_all_the_urls_of_val_doise_townhalls
	mails = []
	t[1].each do |v|
		mails << get_the_email_of_a_townhal_from_its_webpage(v)
	end
	t[1] = mails
	return t
end

puts union[0]