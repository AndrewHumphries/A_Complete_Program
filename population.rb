#includes these automatically when this file is executed.
require_relative "lib/setup.rb"
require_relative "lib/analytics.rb"
#create new class "Population"
class Population
  #setter/getter for instance variable called analytics.
attr_accessor :analytics
#when a new instance of population is created, the following is going to happen —
def initialize
  #local variable called "areas" and that's going to be = to an
  #instance of the Setup class, which has an instance variable called
  #areas, which is all of the information from the original csv,
  #converted to a set of hashes by the CSVReader, then converted to a
  #set of instances of the Area class (by the Area method), and then
  #finally converted into an instance of the setup class, which has as an
  #attribute an array of these Area instances. We return this attribute by 
  #calling the getter "areas"
  areas = Setup.new.areas
  #instance variable within population class "analytics" and that's set equal to
  #an instance of the analytics class, with the areas array from the setup class as the
  #argument. 
  @analytics = Analytics.new(areas)
end


def menu
  #system 'clear' clears the terminalf or readability. 
  system 'clear'
  #print "Population Menu" & a bar
  puts "Population Menu"
  puts "---------- #{@analytics.areas.length}"
  #take instance variable analytics, calls the getter for "options", which returns the menu. 
  #iterates over every hash in the array "options" and does following:
  @analytics.options.each do |opt|
    #prints an interpolated string based on each hash in the options array. 
    puts "#{opt[:menu_id]}. #{opt[:menu_title]}"
  end
end

def run
  #set local variable stop = to false. We're actually checking that it's not :exit, so it's not
  #important that this is a boolean false.
  stop = false
  #while stop does not equal exit (right now, since I just set it equal to false), the program will:
  while stop != :exit do
    #prints out the menu for this instance of the Population class.
    self.menu
    print "Choice:"
    #create local variable "choice" equal to user input, stripped, converted to integer.
    choice = gets.strip.to_i
    #reset local variable stop to whatever returns at the end of the ANALYTICS run method, based on 
    #user choice. 
    stop = @analytics.run(choice) 
    #if the ANALYTICS run method returns object :exit, print "exiting." 
    if stop == :exit
      puts "Exiting"
    #if analytics run method returns anything else, print hit enter to continue (with line break)
    #and then waits for user to hit enter ('gets')
    #when user hits enter, I return to top of while loop. 
    else
      print "\Hit enter to continue"
      gets
    end
  end
end
end
#creates instance of population class, allowing program to run. 
  p = Population.new
  p.run
  