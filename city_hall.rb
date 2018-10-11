require 'rubygems'
require 'nokogiri'   
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(link)
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{link}"))
	puts page.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
end

def get_all_the_urls_of_val_doise_townhalls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	news_links = page.css("a.lientxt")
	news_links.each{|link| get_the_email_of_a_townhal_from_its_webpage(link['href'].delete_prefix('.'))}
end

get_all_the_urls_of_val_doise_townhalls()