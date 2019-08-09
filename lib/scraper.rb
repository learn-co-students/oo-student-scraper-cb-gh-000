require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card")
    students_array = []
    students.each do |student|
      sHash = {}
      sHash[:name] = student.css(".student-name").text
      sHash[:location] = student.css(".student-location").text
      sHash[:profile_url] = student.css("a").attribute('href').text
      students_array << sHash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    sHash = {}
    socials = page.css(".social-icon-container a")
    socials.each do |s|
      if s.attribute('href').text.include?("github")
        sHash[:github] = s.attribute('href').text
      elsif s.attribute('href').text.include?("linkedin")
        sHash[:linkedin] = s.attribute('href').text
      elsif s.attribute('href').text.include?("twitter")
        sHash[:twitter] = s.attribute('href').text
      else
        sHash[:blog] = s.attribute('href').text
      end
    end
    if page.css("div.profile-quote") != nil
      sHash[:profile_quote] =  page.css("div.profile-quote").text
    end
    if page.css(".description-holder p") != nil
      sHash[:bio] = page.css(".description-holder p").text
    end
    sHash
  end

end
