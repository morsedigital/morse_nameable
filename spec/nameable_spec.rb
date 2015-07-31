require 'spec_helper'

RSpec.describe Nameable, type: :module do

  class Thing < OpenStruct 
    include ActiveModel::Validations
    include Nameable
    def initialize(*args)
      super
    end
    def self.column_names
      []
    end
    def errors_add(sym,text)
      @errors[sym]=text
    end
  end
  class ThingWithNoFields < Thing 
    def self.column_names
      []
    end
  end
  class ThingWithFirstname < Thing 
    def self.column_names
      %w{firstname} 
    end
  end
  class ThingWithLastname  < Thing
    def self.column_names
      %w{lastname} 
    end
  end
  class ThingWithAllFields < Thing
    def self.column_names
      %w{firstname lastname} 
    end
  end

  let(:firstname){"Terry"}
  let(:lastname){"Shuttleworth"}
  let(:thing){ThingWithAllFields.new(firstname: firstname,lastname: lastname)}

  describe "validations" do
    context "where the includer has all name fields" do
      context "where all the values are present" do
        let(:thing){ThingWithAllFields.new(firstname: "Terry", lastname: "S")}
        it "should be_valid", focus: true do
          expect(thing.errors.size).to eq(0)
        end
      end
      context "where a value is missing" do
        let(:thing){ThingWithAllFields.new(firstname: "", lastname: "S")}
        it "should not be_valid" do
          thing.valid?
          expect(thing.errors.size>0).to be_truthy
        end
      end
    end
    context "where the includer has only firstname" do
      let(:thing){ThingWithFirstname.new(firstname: "Terry")}
      it "should not be_valid" do
        thing.valid?
        expect(thing.errors.size>0).to be_truthy
      end
    end
    context "where the includer has only lastname" do
      let(:thing){ThingWithLastname.new(lastname: "Terry")}
      it "should not be_valid" do
        thing.valid?
        expect(thing.errors.size>0).to be_truthy
      end
    end
    context "where the includer has no name fields" do
      let(:thing){ThingWithNoFields.new}
      it "should not be_valid" do
        thing.valid?
        expect(thing.errors.size>0).to be_truthy
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
