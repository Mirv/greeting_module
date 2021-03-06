module CustErrorLocation
  # dynamically finds the calling method name & file
  # trace 2 is the 2nd line of the ruby stack
  def err_location(msg = "", trace_line = 2)
    location = "#{caller_name(trace_line)} in ..."
    file_error = "#{msg} in #{location}"
  end
  
  def caller_name(retrieve_line = 1)
    caller[retrieve_line][/`([^']*)'/, 1]
  end

  # Needs to have type as class/module
  def type_error(value, type)
    raise(ArgumentError, "NIL") unless value
    value.is_a? type
  end
end

