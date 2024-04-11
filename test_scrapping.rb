require 'nokogiri'
require 'open-uri'

puts "Enter a search term"
search_term = gets.chomp

doc = Nokogiri::HTML(URI.open("https://www.scrapethissite.com/pages/forms/?q=#{search_term}"))

pages = doc.css(".pagination a")[-2].content.to_i

teams = {}

(1..pages).each do |page_num|
  puts "Scraping page #{page_num}"
  doc = Nokogiri::HTML(URI.open("https://www.scrapethissite.com/pages/forms/?q=#{search_term}&page_num=#{page_num}"))
  doc.css("tr.team").each do |team|
    team_name = team.at(".name").content.strip
    team_wins = team.at(".wins").content.to_i

    teams[team_name] ||= 0
    teams[team_name] += team_wins
  end
end

teams.each do |team_name, team_wins|
  puts "#{team_name} => #{team_wins}"
end