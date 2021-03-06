require 'message_system.rb'

describe "#intialization" do
  context "class object inputs" do
    let(:greeting) { greet(valid_inputs.dup) }

    it "should have successfully initialized" do
      expect(greeting).to be_truthy
    end
    
    it "should have keys" do
      greeting.assemble_loaders
      expect(greeting.names).to have_key(:template)
      expect(greeting.names).to have_key(:company)
    end
  end
end

def valid_inputs
  {
    firstName: "Candy", lastName: "Pace", template: "Default", 
    company: "The Grand Budapest Hotel", directory: "lib/data"
  }
end

def greet(hash)
  MessageSystem.new(hash)
end
  
