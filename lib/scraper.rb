require 'open-uri'
require 'pry'

class Scraper

	def self.scrape_index_page(index_url)
		doc = Nokogiri::HTML(open(index_url))
		students = []
		doc.css("div.roster-cards-container").each do |card|
			card.css(".student-card a").each do |student|
				name = student.css('.student-name').text
				location = student.css('.student-location').text
				profile_url = student.attr('href')
				students << {:name => name, :location => location, :profile_url => profile_url}
			end
		end
		students     
	end

	def self.scrape_profile_page(profile_url)
		profile_page = Nokogiri::HTML(open(profile_url))
		student_attr = {}

		links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
		links.each do |link|
			if link.include?("linkedin")
				student_attr[:linkedin] = link
			elsif link.include?("github")
				student_attr[:github] = link
			elsif link.include?("twitter")
				student_attr[:twitter] = link
			else 
				student_attr[:blog] = link 
			end 
		end
		student_attr[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
		student_attr[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
		student_attr
	end
end
