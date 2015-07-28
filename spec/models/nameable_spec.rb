require 'spec_helper'

RSpec.describe Nameable, type: :module do

  class ThingWithNoFields 
    def self.column_names
      []
    end
  end
  class ThingWithFirstname 
    def self.column_names
      %w{firstname} 
    end
  end
  class ThingWithLastname 
    def self.column_names
      %w{lastname} 
    end
  end
  class ThingWithAllFields<OpenStruct
    def self.column_names
      %w{firstname lastname} 
    end
  end

  let(:firstname){"Terry"}
  let(:lastname){"Shuttleworth"}
  let(:thing){ThingWithAllFields.new(firstname: firstname,lastname: lastname)}

  describe "when included" do
    context "where the includer has all name fields" do
      it "should not get in the way of creation" do
        expect{ThingWithAllFields.include(Nameable)}.to_not raise_error
      end
    end
    context "where the includer has only firstname" do
      it "should raise error" do
        expect{ThingWithFirstname.include(Nameable)}.to raise_error(RuntimeError) 
      end
    end
    context "where the includer has only lastname" do
      it "should raise error" do
        expect{ThingWithLastname.include(Nameable)}.to raise_error(RuntimeError) 
      end
    end
    context "where the includer has no name fields" do
      it "should raise error" do
        expect{ThingWithNoFields.include(Nameable)}.to raise_error(RuntimeError) 
      end
    end
  end

  describe "full_name" do
    it "should return firstname lastname" do
      expect(thing.full_name).to eq("#{firstname} #{lastname}")
    end
  end
  describe "proper_name" do
    it "should return LASTNAME, firstname" do
      expect(thing.proper_name).to eq("#{lastname.upcase}, #{firstname}")
    end
  end

end
