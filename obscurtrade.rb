
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def coinmarketcap
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	nom = []
	prix = []
	page.xpath('//a').each do |v|
		if v.to_s.include?('class="currency-name-container link-secondary"')
			nom << v.text
		elsif v.to_s.include?('class="price"')
			prix << v.text
		end
	end
	return my_hash = Hash[nom.zip(prix)]
end

puts coinmarketcap