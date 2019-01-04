load 'greeters/time_in_hours.rb'
load 'loaders/load_greeting.rb'

## TimeToGreeting
#
# In:   user input ...timezone, startTimeStamp.  Loaded via file: greetings
# Opt:  directory to find the files
# Out:  Greetings if nothing found otherwise a greeting based on the time
#
class TimeToGreeting
  def initialize(args)
    @parameters = args
    @default_greetings = args[:default_greetings]
    @hours = TimeInHours.new(args).time_in_hours  
    @greetings = @default_greetings || greetings_file_load
  end

  def greetings_file_load
    LoadGreeting.new(@parameters).execute_process
  end

  def valid?
    @hours && @greetings
  end
  
  def execute_process
    return "Greetings" unless valid?
    greetings = GreetingSelector.data_from_array_of_hashes(@greetings[:greetings]) 
    greeting_message = greetings.find(@hours).message
  end
end
