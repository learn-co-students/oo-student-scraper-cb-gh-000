require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    students = []
    index_folder = index_url.split(/index\.html/)[0]
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").each do |card|
      students << {
        name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: index_folder + card.css("a").attribute("href").value
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student = {
      profile_quote: doc.css(".profile-quote").text,
      bio: doc.css(".bio-content .description-holder").text.strip
    }

    doc.css(".social-icon-container a").each do |social|
      key = social.css("img").attribute("src").value.match(/img\/\w+/)[0][4..-1]
      key = "blog" if key == "rss"
      student[key.to_sym] = social.attribute("href").value
    end

    student
  end
end
