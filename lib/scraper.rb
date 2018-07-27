require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card a").each do |student|
    name = student.css(".student-name").text
    location = student.css(".student-location").text
    profile_url = student.attr("href")
    students << { :name => name, :location => location, :profile_url => profile_url }
  end
  students
  end

  def self.scrape_profile_page(profile_url)

    profile_data = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    doc.css(".social-icon-container a").each do |icon|
        social = icon.attr("href")

        case true
          when social.include?("facebook")
            profile_data[:facebook] = social
          when social.include?("twitter")
            profile_data[:twitter] = social
          when social.include?("github")
            profile_data[:github] = social
          when social.include?("linkedin")
            profile_data[:linkedin] = social
          else
            profile_data[:blog] = social
        end
    end
    profile_data[:profile_quote] = doc.css(".profile-quote").text
    profile_data[:bio] = doc.css(".bio-content p").text

    profile_data
  end

end
