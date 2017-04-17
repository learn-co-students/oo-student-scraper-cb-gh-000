require 'open-uri'
require 'pry'

class Scraper

=begin
  Example return value:

    [
      {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
      {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
      {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"},
      {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "./fixtures/student-site/students/lorenzo-oro.html"},
      {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "./fixtures/student-site/students/marisa-royer.html"}
    ]
=end
  def self.scrape_index_page(index_url)
    # Initialize empty array to hold unique hashes for each student

    # Get list of students

    # For each student in the list, create a hash
    # In each student hash, store the following attributes:
    # Student name (e.g. "Abby Smith")
    # Student location (e.g. "Brooklyn, NY")
    # Student's profile URL (e.g. "./fixtures/student-site/students/abby-smith.html")
    # Add student hash to the array of student hashes

    # Return array of student hashes
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
    # Create hash to hold attributes and values for the student

    # Scrape profile page for twitter link
      # Add twitter link as the value for the :twitter attribute

    # Scrape profile page for linkedin link
      # Add linkedin link as the value for the :linkedin attribute

    # Scrape profile page for github link
      # Add github link as the value for the :github attribute

    # Scrape profile page for blog link
      # Add blog link as the value for the :blog attribute

    # Scrape profile page for profile quote
      # Add profile quote as the value for the :profile_quote attribute

    # Scrape profile page for bio
      # Add bio as the value for the :bio attribute

    # Return hash of attributes
  end

end

