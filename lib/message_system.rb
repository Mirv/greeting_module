require_relative 'assemble_loaders.rb'
require_relative 'template_tool.rb'

class MessageSystem
  attr_reader :greeting_message, :names, :result
  
  def initialize(**args)
    @names = args
    assemble_loaders
    @result = call_templater(@names)
  end

  ## assemble_loaders
  #
  # In:  @names hash
  # Out: hash exposed via data of user's specific data set - merged to @names
  #
  def assemble_loaders
    loaders = AssembleLoaders.new(@names)
    loaders.process_loaders
    @names.merge!(loaders.result)
  end
  
  ## call_templater
  #
  # In:   @names hash with raw template & all the assemble_loader data for message
  # Out:  message to be sent
  #
  def call_templater(args)
    TemplateTool.new(args).result
  end
end

