require_relative '../data_crypto'
require 'open-uri'

describe "data_crypto" do
  it "returns a hash of cryptocurrency names and prices" do
    allow(URI).to receive(:open).and_return(File.open('spec/fixtures/crypto_data.html'))
    
    crypto_currencies = data_crypto
  
    expect(crypto_currencies.class).to eq(Hash)
    
    expect(crypto_currencies.all? { |crypto| crypto.is_a?(String) }).to eq(true)

    expect(crypto_currencies.all? { |value| value.is_a?(String) }).to eq(true)
  end
end