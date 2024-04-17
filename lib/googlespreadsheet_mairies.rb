require 'json'
require 'nokogiri'
require 'open-uri'
require 'google_drive'

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

def save_as_spreadsheet
  name_emails = info_mairie

  session = GoogleDrive::Session.from_config("config.json")

  spreadsheet = session.create_spreadsheet('Mairies du Val d\'Oise')

  ws = spreadsheet.worksheets[0]
  ws[1, 1] = 'Ville'
  ws[1, 2] = 'E-mail'

  name_emails.each_with_index do |(name, email), index|
    ws[index + 2, 1] = name
    ws[index + 2, 2] = email
  end

  (1..ws.num_rows).each do |row|
    (1..ws.num_cols).each do |col|
      p ws[row, col]
    end
  end

  session.upload_from_file('mairies_du_val_doise.csv', 'Mairies du Val d\'Oise', convert: false)

  puts "Spreadsheet saved with mairies information"
end