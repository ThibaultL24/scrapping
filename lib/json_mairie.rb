require 'json'
require 'nokogiri'
require 'open-uri'
require 'csv'

class EmailScrapper
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

  def save_as_JSON
    name_emails = info_mairie
    File.open('emails.json', 'w') do |file|
      file.write(JSON.pretty_generate(name_emails))
    end
    puts "E-mails saved to emails.json"
  end

  def save_as_csv
    name_emails = info_mairie

    CSV.open('emails.csv', 'w') do |csv|
      csv << ['Ville', 'E-mail']
      name_emails.each do |name, email|
        csv << [name, email]
      end
    end

    puts "E-mails saved to emails.csv"
  end
end

scraper = EmailScrapper.new
scraper.save_as_csv