require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = html.css("div.roster-cards-container div.student-card")
    students.map do |student|
      {:name => student.css("a div.card-text-container h4.student-name").text,
      :location => student.css("a div.card-text-container p.student-location").text,
      :profile_url => student.css("a").attribute("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    html = Nokogiri::HTML(open(profile_url))

    social_links = html.css("div.social-icon-container a")

    profile_quote = html.css("div.vitals-text-container div.profile-quote").text
    bio = html.css("div.details-container div.description-holder p").text

    profile[:profile_quote] = profile_quote
    profile[:bio] = bio

    social_links.each do |social_link|
      if social_link.attribute("href").value.include?("twitter")
        profile[:twitter] = social_link.attribute("href").value
      elsif social_link.attribute("href").value.include?("linkedin")
        profile[:linkedin] = social_link.attribute("href").value
      elsif social_link.attribute("href").value.include?("github")
        profile[:github] = social_link.attribute("href").value
      else
        profile[:blog] = social_link.attribute("href").value
      end
    end

    profile
  end

end
