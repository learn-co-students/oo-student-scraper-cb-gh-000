require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # :profile_url
    # doc.css('.student-card a').attr('href').value

    # :name
    # doc.css('.student-card a').css('.student-name').text

    # :location
    # doc.css('.student-card a').css('.student-location').text

    students = []
    doc.css('.roster-cards-container').each do |student_card|
      student_card.css('.student-card a').each do |student|
        profile_url = "#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        students << { name: name, location: location, profile_url: profile_url }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student = {}
    doc.css('.social-icon-container a').each do |link|
      link_item = link.attr('href')
      if link_item.include?('twitter')
        student[:twitter] = link_item
      elsif link_item.include?('linkedin')
        student[:linkedin] = link_item
      elsif link_item.include?('github')
        student[:github] = link_item
      else
        student[:blog] = link_item
      end
    end

    student[:profile_quote] = doc.css('.profile-quote').text if doc.css('.profile-quote')
    student[:bio] = doc.css('.description-holder p').text if doc.css('.description-holder p')

    student

  end

end
