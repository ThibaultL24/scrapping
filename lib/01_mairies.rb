require 'nokogiri'
require 'open-uri'

def info_mairie
  url = "https://www.amf.asso.fr/m/annuaire/?refer=departement&dep_n_id=95"
  doc = Nokogiri::HTML(URI.open(url))

  villes_habitants = {}

  doc.xpath("//*[@id='tab-classic']/div[1]/table/tbody/tr[position() > 1]").each do |row|
    name = row.at_xpath("./td[1]/a").text.strip
    population = row.at_xpath("./td[3]").text.strip
    villes_habitants[name] = population if name && population
  end

  villes_habitants
end

villes_habitants = info_mairie

villes_habitants.each do |name, population|
  puts "#{name} => #{population}"
end