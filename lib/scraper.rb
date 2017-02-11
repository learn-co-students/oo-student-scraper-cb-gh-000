require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    Array.new.tap do |students|
      doc.search('div.student-card').each do |student_card|
        students << { name:        student_card.search('div.card-text-container h4.student-name').text,
                      location:    student_card.search('div.card-text-container p.student-location').text,
                      profile_url: "./fixtures/student-site/#{student_card.search('a').attribute('href').value}" }
      end
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    Hash.new.tap do |profile|
      doc.search('div.social-icon-container a').each do |social_links|
        case social_links.attribute("href").value
          when /^https:\/\/twitter\.com\/.*/
            profile[:twitter] = social_links.attribute("href").value
          when /^https:\/\/www\.linkedin\.com\/.*/
            profile[:linkedin] = social_links.attribute("href").value
          when /^https:\/\/github\.com\/.*/
            profile[:github] = social_links.attribute("href").value
          else
            profile[:blog] = social_links.attribute("href").value
        end
      end
      profile[:profile_quote] = doc.search('div.profile-quote').text
      profile[:bio] = doc.search('div.bio-content div.description-holder p').text
    end
  end
  
end

