require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = File.open(index_url) { |f| Nokogiri::HTML(f) }
    base_path = index_url[(0..index_url.rindex("index")-1)]
    profiles = []
    doc.css(".student-card").each do |card|
      student = {
        :name        => card.css(".student-name").text,
        :location    => card.css(".student-location").text,
        :profile_url => File.join(base_path, card.css("a").attribute("href").value)
      }
      profiles << student
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = File.open(profile_url) { |f| Nokogiri::HTML(f) }
    links = doc.css(".vitals-container .social-icon-container").children.collect{|child| child.attribute("href").value.downcase if !child.attribute("href").nil? }.compact
    student = {
      :twitter       => links.detect { |e| e.include?("twitter") },
      :linkedin      => links.detect { |e| e.include?("linkedin") },
      :github        => links.detect { |e| e.include?("github") },
      :blog          => links.detect { |e|
                         !e.include?("linkedin") && !e.include?("twitter") &&
                         !e.include?("youtube") && !e.include?("github") && !e.eql?("\#")
                        },
      :profile_quote => doc.css(".vitals-container .profile-quote").text,
      :bio           => doc.css(".details-container .bio-content .description-holder p").text
    }
    student.delete_if{|key, value| value.nil?}
  end

end
