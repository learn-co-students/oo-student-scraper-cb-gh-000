require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students_scrape = doc.css('div.student-card')

    students_scrape.collect do |student|
      {
          :name => student.css('h4').text,
          :location => student.css('p').text,
          :profile_url => student.css('a').attribute('href').value
      }

    end

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    profile[:profile_quote] = doc.css('div.profile-quote').text
    profile[:bio] = doc.css('div.bio-content div.description-holder p').text
    social = doc.css('div.social-icon-container a')
    s_name = %w(twitter github linkedin)
    social.each do |link|
      name = link.attr('href').split('/')[2].gsub('.com', '').gsub('www.', '')
      s_name.include?(name) ? name : name = 'blog'
      profile[name.to_sym] = link.attr('href')
    end
    profile
  end

end

