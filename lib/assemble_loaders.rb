require_relative 'cust_error_location'
require_relative 'loaders/load_guest'
require_relative 'loaders/load_company'
require_relative 'loaders/load_template'
require_relative 'loaders/load_message'
require_relative 'logging'

## AssembleLoaders
#
# In:  @names hash of options loaded to select correct data sets from files
#  
#  Assumes names hash if it arrives has validated values from calling object
#
# Out: exposes data which is a hash of the dataset or nil's which top level tests? 
#
class AssembleLoaders
  include CustErrorLocation
  include Logging
  
  attr_reader :result
  
  def initialize(**args)
    @names =    args
    @files =    args[:files] || [
                'LoadGuest', 
                'LoadCompany',
                'LoadMessage'
      ]
  @result =       Hash.new
    check_required_fields(@names)
  end

  def process_loaders
    @files.each do |x|
      begin
        obj = Object.const_get(x)
        obj = load_single(obj)
      rescue NameError => e
        Logging::LogIt(err_location("Issue with class interface for #{x}", 2))
        Logging::LogIt(caller_locations.first)
        raise(NameError)
      end
      @result.merge!(obj.result)
    end
  end
  
  def load_single(obj)
    # Loading files and error if not loaded
    obj_name = obj.class.name
    msg = "Data File not loaded #{obj_name} - ensure path & name were correct"
    file_msg = err_location(msg, 2)
    raise(ArgumentError, file_msg) unless obj = obj.new(@names)
    obj.process
    
    # Check all entries in obj exposed data have values
    entry_msg = "Entries missing in #{obj} file"
    # Ensure no blank in hash
    obj.result.each do |x, y|
      raise(ArgumentError, err_location(entry_msg)) if !y || y && y==""
    end
    return obj
  end
  
  def check_required_fields(args)
    # Explicit pre checks 
    # pre lookup checks - as "" as value in hash is not valid, incorrectly
    raise ArgumentError, "firstName was empty" if args[:firstName].nil? || args[:firstName].empty?
    raise ArgumentError, "lastName was empty"  if args[:lastName].nil? || args[:lastName].empty?
    raise ArgumentError, "company was empty"   if args[:company].nil? || args[:company].empty?  
    # raise ArgumentError, "template was empty"  if args[:template].nil? ||args[:template].empty?
 end
end
