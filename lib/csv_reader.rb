class CSVReader
  attr_accessor :fname, :headers
  def initialize(filename)
    @fname = filename
  end

  def headers=(header_str)
    @headers = header_str.split(',')
  
    @headers.map! do |h|
      #remove quotes
      new_header = h.gsub('"', '')
      #remove new line
      new_header.strip!
      #convert to a symbol
      new_header.underscore.to_sym
    end
  end

    def create_hash(values)
      h = {}
      @headers.each_with_index do |header, i|
        #remove new lines from the value
        value = values[i].strip.gsub('"', '')
        h[header] = value unless value.empty?
      end
      h
    end

    def read
      #creates a new instance of "File" class, wtaking two arguments — first specifies file name/location, second specifies permissions (read-only)
      f = File.new(@fname, 'r')
      #grabs the file's headers and ...? what is readline? 
      self.headers = f.readline

      #iterate over the file as long as I haven't reached end of file (eof?) and the next_line = f.readline
      while (!f.eof? && next_line = f.readline)
        #set a local variable "values" equal to next_line, a string that ends where we next find a comma.
        values = next_line.split(',')
        #create a local variable "hash", using my method "create_hash" and the values variable just created.
        hash = create_hash(values)
        #before this code ends, it will pass the hash I've created to whatever block yield invokes.
        yield(hash)
      end
    end

    end



end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'|1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "-").
    downcase
  end
end


