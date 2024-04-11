require_relative '../data_crypto'
require 'open-uri'

describe "info_mairie" do
  it "returns a hash of names and prices of mairies" do
    allow(URI).to receive(:open).and_return(StringIO.new("https://www.aude.fr/annuaire-mairies-du-departement"))
    
    name_emails = info_mairie

    expect(name_emails.class).to eq(Hash)
    
    expect(name_emails.values.all? { |email| email.is_a?(String) }).to eq(true)
  end
end
