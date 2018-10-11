require 'rubygems'
require 'nokogiri'   
require 'open-uri'

# Maintenant, nous allons te faire travailler sans –trop– te mâcher le travail. 
# Nous allons te demander de récupérer la liste complète des députés de France, puis de récupérer leurs adresses email.
# Tu devras trouver par toi-même le site à scrapper, et tu devras stocker toi même les déuputés dans une array de hashs qui contiennent first_name, last_name, et email.
# Cet exercice te demandera d'aller voir quelques annuaires, et de travailler sur celui qui te semble le mieux.

def deputy
	first = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/regions/(vue)/tableau")).css("td:nth-child(2)")
	last = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/regions/(vue)/tableau")).css("td:nth-child(3)")

	first_name = []
	last_name = []

	first.each do |link|
    	update = link.text
    	first_name << update
  	end

  	last.each do |link|
    	update = link.text
    	last_name << update
  	end

  	hash = Hash[first_name.zip(last_name)]
  	puts hash.map {|first_name, last_name| {:Prénom => first_name, :Nom => last_name}}

end

def get_the_email_of_deputys(link)
	emails = []
    page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{link}"))
    nodeset = page.css("#haut-contenu-page > article > div.contenu-principal.en-direct-commission.clearfix > div > dl > dd:nth-child(8) > ul > li:nth-child(1) > a[href]")
    nodeset = nodeset.map {|element| element["href"].delete_prefix("mailto:")}
    nodeset.each do |link|
    	emails << link
  	end
  	puts emails
end

def get_the_profile_links
    contact = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/regions/(vue)/tableau")).css("td:nth-child(8) a")
    contact.each{|link| get_the_email_of_deputys(link['href'].delete_prefix('.'))}
end

deputy()

get_the_profile_links()