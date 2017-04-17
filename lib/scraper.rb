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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    # Scrape profile page for twitter link

    # Scrape profile page for linkedin link

    # Scrape profile page for github link

    # Scrape profile page for blog link

    # Scrape profile page for profile quote

    # Scrape profile page for bio
      # Add bio as the value for the :bio attribute

    { :twitter => , :linkedin =>, :github => , :blog => , :profile_quote => , :bio =>  }
  end

end

