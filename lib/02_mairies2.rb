require 'nokogiri'
require 'open-uri'

def info_mairie
  url = "https://www.aude.fr/annuaire-mairies-du-departement"
  doc = Nokogiri::HTML(URI.open(url))

  name_emails = {}

  doc.xpath("//article[@class='directory-block__item']").each do |element|
    name = element.at("h2.directory-block__title").text
    emails = element.at("p.-email a").text
    name_emails[name] = emails
  end

  name_emails
end

name_emails = info_mairie

name_emails.each do |name, emails|
  puts "#{name} => #{emails}"
end