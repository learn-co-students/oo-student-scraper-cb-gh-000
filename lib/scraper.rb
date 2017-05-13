require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = open("./fixtures/student-site/index.html")
    students = Nokogiri::HTML(html).css(".student-card")
    students.each do |student|
      student_array << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attr("href").value
      }
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    studentHTML =  Nokogiri::HTML(html)

    vitals = studentHTML.css(".vitals-container")
    details = studentHTML.css(".details-container")

    student_profile = {
      :profile_quote=>vitals.css(".profile-quote").text,
      :bio=> details.css(".description-holder p").text
    }

    social_links = vitals.css(".social-icon-container a").map { |link| link.attribute("href").value }

    social_links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end

    student_profile
  end

end
