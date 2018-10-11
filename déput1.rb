
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def deput
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/qui"))
	nom = []
	prenom = []
	page.xpath('//ul/li/div/p/a/strong').each do |v|
		if v.to_s.include?('<strong>')
			nom << v.text.gsub('Mme ', '').gsub('M. ', '').partition(" ")[0]
		elsif v.to_s.include?('<strong>')
			prenom << v.text.gsub('Mme ', '').gsub('M. ', '').partition(" ")[2]
		end
	end
	return nom,prenom
end

def get_the_email(s)
	page = Nokogiri::HTML(open(s))
	t = []
	m = 0
	t = page.css('a')
	t.each do |v|
		if v.to_s.include?("@")
			m = v.to_s.partition('mailto:')[2].partition('">')[0]
			break
		end
	end
	return m
end

def deput
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/qui"))
	tab = []
	mails = []
	page.xpath('//ul/li/div/p/a').each do |v|
		if v.to_s.include?('<strong>')
			tab <<"http://www2.assemblee-nationale.fr/deputes/fiche/" + v.to_s.partition('/deputes/fiche/')[2].partition('"><')[0]
		end
	end
	tab.each do |v|
		mails << get_the_email(v)
	end
	return mails
end

puts deput