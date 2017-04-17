class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  # Stores all Students
  @@all = []

  def initialize(student_hash)
    # Use metaprogramming to assign student attributes according to key/value pairs in hash argument
    # Use #send method

    # Add the new student to Student class variable holding array of all Students
  end

  def self.create_from_collection(students_array)
    # Iterate over student hashes stored in argument holding array of students
    # Create a new individual student for each hash

    # Return all students
  end

  def add_student_attributes(attributes_hash)
    # Use metaprogramming to assign student attributes according to key/value pairs in hash argument
    # Use #send method
  end

  def self.all
    # Return Student class variable holding array of all Students
  end
end

