load 'greet/time_zone_names.rb'

describe "initialized" do
  let(:timezone){ TimeZoneNames.new("US/Central") }
  
  context "worked" do
    it "should be truthy" do
      expect(timezone).to be_truthy
    end
    
    it "should return zone abbreviation" do
      expect(timezone.abbreviation).to eq('CST')
    end
  end
  
  context "fails" do
    it "raises error if timezone not string" do
      expect{TimeZoneNames.new("")}.
      to raise_error(ArgumentError, "timezone was empty")
    end
    
    it "raises error if timezone not string" do
      expect{TimeZoneNames.new(13)}.
      to raise_error(ArgumentError, "timezone is not valid String")
    end
    
    it "raises error if timezone given isn't real timezone" do
      expect{TimeZoneNames.new("3")}.
      to raise_error(ArgumentError, "Non-valid TimeZone")
    end

  end
        
end