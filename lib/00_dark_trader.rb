require 'nokogiri'
require 'open-uri'

def data_crypto
  url = "https://coinmarketcap.com/all/views/all/"
  doc = Nokogiri::HTML(URI.open(url))
  
  crypto_page = doc.xpath("//tr[contains(@class, 'cmc-table-row')]")
  
  crypto_currencies = {}
  
  crypto_page.each do |crypto_row|
    name = crypto_row.xpath(".//td[3]").text.strip
    price = crypto_row.xpath(".//td[5]").text.strip
    crypto_currencies[name] = price
  end
  
  crypto_currencies
end

crypto_currencies = data_crypto

crypto_currencies.each do |name, price|
  puts "#{name} => #{price}"
end