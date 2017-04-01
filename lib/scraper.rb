require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = Array.new()
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card")
    students.each_with_index do |student,index|
      students_array[index] = {}
      name = student.css(".student-name").text
      students_array[index][:name] = name
      students_array[index][:location] = student.css(".student-location").text
      name = name.downcase.gsub(" ","-")+".html"
      students_array[index][:profile_url] = "./fixtures/student-site/students/#{name}"
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    page = Nokogiri::HTML(open(profile_url))
    social_links = page.css("div.social-icon-container a").collect do |link|
      link.attr("href")
    end
    student_hash = self.assign_links student_hash,social_links
    student_hash[:profile_quote] = page.css(".profile-quote").text
    student_hash[:bio] = page.css(".description-holder p").text
    student_hash
  end

  def self.assign_links hash,links
    socials = [:twitter,:linkedin,:github]
    links.each do |link|
      match = socials.detect{|soc_link| link.include?(soc_link.to_s)}
      if match
        hash[match] = link
      else
        hash[:blog] = link
      end
      socials.delete(match)
    end
    hash
  end

end
