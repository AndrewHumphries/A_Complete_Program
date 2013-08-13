class Analytics
  #create getter/setter method for instance variable named "options"
  attr_accessor :options
  #every time you create an instance of the analytics class, the following happens
  def initialize(areas)
    #the instance variable @areas is set = to the argument "areas" — a collection areas
    @areas = areas
    #run set_options to finalize initialization
    set_options
  end

  def set_options
    #create instance variable named @options, which is an array. 
    @options = []
    #into the array @options, put 6 hashes. Each has three keys — an ID, a title, and a method)
    @options << { menu_id: 1, menu_title: 'Areas count', method: :how_many }
    @options << { menu_id: 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << { menu_id: 3, menu_title: 'Largest Population', method: :largest_pop }
    @options << { menu_id: 4, menu_title: 'How many zips in California?', method: :california_zips }
    @options << { menu_id: 5, menu_title: 'Information for a given zip', method: :zip_info }
    @options << { menu_id: 6, menu_title: 'Exit', method: :exit }
  end

  def run(choice)
    #set local variable "opt" equal to the elements in the @options array that return true for the block in {}
    #the block says — return a new array comprised of the elements of the @options array that have a :menu_id equal to the provided argument "choice"
    #then, finally, return the first element of the array that was just created based on the menu_id provided in argument "choice"
    opt = @options.select { |o| o[:menu_id] == choice }.first
    #if no elements of the @options array return for the "choice" argument provided, return print "invalid choice"
    if opt.nil? 
      puts "Invalid choice"
    #if the new array opt has the element :exit included, do what's next — — what is the != here? 
    elsif opt[:method] != :exit
      #take the array (opt) in question and runs .send, an object method that invokes the method identified by the symbol passed. 
      #In this case, that's the method associated with :method in the array opt we created. 
      self.send opt[:method]
      #I don't know what :done is doing...?
      :done
    else
      #otherwise, just run the method. How is this different than what we just did for :exit? 
      opt[:method]
    end
  end

  def how_many
    #for the method how_many, do a simple string interpolation. 
    puts "There are #{@areas.length} areas"
  end

  def smallest_pop
    #create a new variable, "sorted", an array, that's going to be created by sorting the @areas in a way I specify.
    sorted = @areas.sort do |x, y|
      #sort the array by comparing the estimated_population of one element to the estimated population of another.
      #since these are integers, it will default to sorting low to high. 
      x.estimated_population <=> y.estimated_population
    end
    #create a variable called smallest
    #smallest will be created by taking the "sorted" array and dropping every element up to the first element that returns nil for the test I write.
    #the test — drop the elements as long as estimated_population is 0. Once you have a population over zero, build the array with all the elements. Then, return the first element. 
    #That first element is the variable "smallest"
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    #print string interpolation using smallest hash I just ID'd. 
    puts "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}"
  end

#same as smallest_pop, just with a 'reverse' method run the sorted array. 
  def largest_pop
    sorted = @areas.sort do |x, y|
      x.estimated_population <=> y.estimated_population
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first

    puts "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
  end

  def california_zips
    #create a variable, c. c will be equal to the number of elements that have a .state value == "CA"
    c = @areas.count { |a| a.state == "CA"}
    #prints string interpolation using the integer c we just created. 
    puts "There area #{c} zip code matches in California"
  end

  def zip_info
    #print a phrase "Enter" zip, prompting user to return a string.
    print "Enter zip: "
    #creates variable zip, which is going to be an integer. 
    #gets reads the next line in the interface — what the user plugs in. 
    #strip the string found in the gets method of all white space. 
    #converts to an integer...? I think? 
    zip = gets.strip.to_i
    #create new variable "zips"
    #zips (an array) will be created by taking the @areas array and selecting all of the elements that meet my test. 
    #my test will be if the zipcode of the element is == to the zip interger I just created from user input
    zips = @areas.select { |a| a.zipcode == zip }
    #if zips is not empty (if the empty? test returns false) then prints a blank spot.
    unless zips.empty? 
      puts ""
      #then it iterates over the array takes every element it finds and prints them. (Does this print every value in every hash for that zip?)
      zips.each { |z| puts z }
    else
      puts 
      #if the empty? test is true (the array is empty), we print an empty message. 
      puts "Zip not found"
    end
  end


