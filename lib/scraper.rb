require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    # For each student in the list, create a hash with student's name, location, and profile URL
    doc.css(".student-card").each do |student_card|
      # Student name (e.g. "Abby Smith")
      name = student_card.css(".student-name").text

      # Student location (e.g. "Brooklyn, NY")
      location = student_card.css(".student-location").text

      # Student's profile URL (e.g. "./fixtures/student-site/students/abby-smith.html")
      profile_url = "./fixtures/student-site/#{student_card.css("a").first["href"]}"

      # Add student hash to the array of student hashes
      students << { :name => name, :location => location, :profile_url => profile_url }
    end

    # Return array of student hashes
    students
  end

=begin
     Example return value:

    {
      :twitter=>"http://twitter.com/flatironschool",
      :linkedin=>"https://www.linkedin.com/in/flatironschool",
      :github=>"https://github.com/learn-co,
      :blog=>"http://flatironschool.com",
      :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      :bio=> "I'm a school"
     }
=end
  def self.scrape_profile_page(profile_url)
    student_attributes = {}

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    social_links = doc.css(".social-icon-container a")

    social_links.each do |link|
      link_path = link["href"]

      if link_path.include?("youtube.com")
        next
      elsif link_path.include?("twitter.com")
        student_attributes[:twitter] = link_path
      elsif link_path.include?("linkedin.com")
        student_attributes[:linkedin] = link_path
      elsif link_path.include?("github.com")
        student_attributes[:github] = link_path
      else
        student_attributes[:blog] = link_path
      end
    end

    # Scrape profile page for profile quote
    student_attributes[:profile_quote] = doc.css(".profile-quote").text

    # Scrape profile page for bio
    student_attributes[:bio] = doc.css(".bio-content .description-holder p").text

    student_attributes
  end

end

