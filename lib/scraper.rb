require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    student = {}
    page.css(".student-card a").each do |profile|
      student = {}
      student[:name] = profile.css(".student-name").text
      student[:location] = profile.css(".student-location").text
      student[:profile_url] = profile.attribute("href").value
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile = {}
    profile[:bio] = page.css(".description-holder p").text.strip
    profile[:profile_quote] = page.css(".profile-quote").text.strip
    page.css(".social-icon-container a").each do |a|
      link = a.attribute("href").value.scan(/http.+.com/).last
      if link.include?("twitter")
        profile[:twitter] = a.attribute("href").value
      elsif link.include?("linkedin")
        profile[:linkedin] = a.attribute("href").value
      elsif link.include?("github")
        profile[:github] = a.attribute("href").value
      else
        profile[:blog] = a.attribute("href").value
      end
    end
    profile
  end

end
