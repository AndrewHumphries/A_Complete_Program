#will only be able to create instance of Setup class if classes csv_reader and area are accessible
require_relative 'csv_reader'
require_relative 'area'
class Setup
  #create attribute 'areas'
attr_accessor :areas
  #each time we create an instance of setup class, following will happen.
  def initialize  
    #local variable csv will be created. It will = instance of CSV reader, drawn from "./zipcode-db.cvs"
    csv = CSVReader.new("./free-zipcode-database.csv")
    #areas will have default value of an empty array
    @areas = []
    #I will run csv.read, which will return a hash based on a file of information.
    csv.read do |item|
      #the hash I get from csv.read will be formatted according to the Area class, and then put into the @areas array.
      @areas << Area.new(item)
    end
  end
end
