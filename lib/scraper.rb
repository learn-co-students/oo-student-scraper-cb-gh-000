require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index = Nokogiri::HTML(html)

    students = []
    index.css(".roster-cards-container .student-card").each do |value|
      student = {}
      student[:profile_url] = "./fixtures/student-site/#{value.css("a").attr("href")}"
      student[:name] = value.css("a .card-text-container .student-name").text()
      student[:location] = value.css("a .card-text-container .student-location").text()
      students << student
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    student = {}

    profile.css(".social-icon-container a").each do |link|
      profile_link = link.attr("href")
      if profile_link.include?("twitter")
        student[:twitter] = profile_link
      elsif profile_link.include?("linkedin")
        student[:linkedin] = profile_link
      elsif profile_link.include?("github")
        student[:github] = profile_link
      else
        student[:blog] = profile_link
      end
    end

    student[:profile_quote] = profile.css(".profile-quote").text() if profile.css(".profile-quote")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end
