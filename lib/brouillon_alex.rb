require 'rubygems'
require 'nokogiri'
require 'open-uri'

site = "https://coinmarketcap.com/all/views/all/"

cryptomonnaies = []

page = Nokogiri::HTML(URI.open(site))
ticker = page.css('td:nth-child(2) > div > a[2]').map(&:text)
price = page.css('td:nth-child(5) > div > a > span').map(&:text)

ticker.each do
    my_hash = Hash[ticker.zip(price)]
    cryptomonnaies << my_hash
end 


puts "#{ticker[4]} => #{price[4]}"
  