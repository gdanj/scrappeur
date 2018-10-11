
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def deput_nom
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/qui"))
	nom = []
	prenom = []
	page.xpath('//ul/li/div/p/a/strong').each do |v|
		if v.to_s.include?('<strong>')
			nom << v.text.gsub('Mme ', '').gsub('M. ', '').partition(" ")[0]
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

def deput_mail
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/qui"))
	tab = []
	mails = []
	i = 0
	nom_prenom = deput_nom
	page.xpath('//ul/li/div/p/a').each do |v|
		if v.to_s.include?('<strong>')
			tab << { "last_name" => nom_prenom[1][i], "first_name" => nom_prenom[0][i], "email" => get_the_email("http://www2.assemblee-nationale.fr/deputes/fiche/" + v.to_s.partition('/deputes/fiche/')[2].partition('"><')[0]) }
			i += 1
		end
	end
	return tab
end

puts deput_mail
