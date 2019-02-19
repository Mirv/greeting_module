require_relative 'deliminators'

class Template
  attr_reader :raw, :deliminator, :start, :stop  # TODO - trim this interface?
  
  def initialize(raw, deliminator)
    @raw = raw
    @start = deliminator.start
    @stop = deliminator.stop

    # read fails silently otherwise
    raise ArgumentError, "Template string blank" if @raw.empty?  
  end
  
  def pull_holders
    pull = @raw.scan(/#{@start}(.*?)#{@stop}/).flatten.uniq
    # puts "Pull #{pull.count > 0} -- raw #{@raw}"
    raise ArgumentError, "No placeholders found in template" if pull.empty?
    return @result = pull
  end
end