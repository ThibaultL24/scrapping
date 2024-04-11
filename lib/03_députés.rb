require 'nokogiri'
require 'open-uri'

def info_deputes
  url = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes"
  doc = Nokogiri::HTML(URI.open(url))

  deputes_info = {}

  doc.xpath('//*[@id="content"]/div').each do |row|
    name = row.xpath('//*[@id="content"]/div/div/ul[1]/li[1]/h2').text
    email = row.xpath('//*[@id="content"]/div/div/ul[1]/li[5]/a[1]').text
    circonscription = row.xpath('//*[@id="content"]/div/div/ul[1]/li[2]/text()').text

    deputes_info[name] = { email: email, circonscription: circonscription }
  end

  deputes_info
end

deputes_info = info_deputes

deputes_info.each do |name, info|
  puts "Nom complet : #{name}" 
  puts "Email : #{info[:email]}"
  puts "Circonscription : #{info[:circonscription]}"
end
