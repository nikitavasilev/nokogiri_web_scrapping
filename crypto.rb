require 'rubygems'
require 'nokogiri'   
require 'open-uri'

def cryptocurrency
	currency_price = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).css(".price")
	currency_name = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).css(".currency-name-container")
	prices = []
	names = []
	
	currency_name.each do |link|
    	update = link.text
    	names << update
  	end
  	
  	currency_price.each do |link|
    	update = link.text
    	prices << update
  	end

  	hash = Hash[names.zip(prices)]
  	puts hash.map {|names, prices| {:Name => names, :Price => prices}}
  	puts "\nThis program is still running. The prices will be updated every hour."
  	puts "If you want to close the program, press: CTRL+C"
end

def secondly_loop
	puts "\nLOADING..."
	puts "WE'RE REFRESHING THE PRICES.."
    last = Time.now
    while true
        yield
        now = Time.now
        _next = [last + 3600,now].max
        sleep (_next-now)
        last = _next
    end
end

secondly_loop {cryptocurrency}

# Dirty Version:
# These all suffer from the same issue: if the actual script/function takes time to run, it makes the loop run less than every second.

=begin
while true
   cryptocurrency()
   sleep 3600
end
=end

#Here is a ruby function that will make sure the function is called (almost) exactly every second,
#as long as the function doesn't take longer than a second: