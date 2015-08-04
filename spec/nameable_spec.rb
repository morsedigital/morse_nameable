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
  class ThingWithAllFieldsAndTitle < ThingWithAllFields
    def title
      "whev"
    end
  end

  let(:firstname){"Terry"}
  let(:lastname){"Shuttleworth"}
  let(:test_string){"whev"}
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

  describe "instance functions" do

    describe "first_name" do
      it "should return firstname" do
        expect(thing.first_name).to eq(thing.firstname)
      end
    end
    describe "first_name=" do
      it "should set firstname" do
        expect(thing.firstname).to_not eq(test_string)
        thing.first_name=test_string
        expect(thing.firstname).to eq(test_string)
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
    describe "surname" do
      it "should return lastname" do
        expect(thing.surname).to eq(thing.lastname)
      end
    end
    describe "surname=" do
      it "should set lastname" do
        expect(thing.lastname).to_not eq(test_string)
        thing.surname=test_string
        expect(thing.lastname).to eq(test_string)
      end
    end

    describe "title" do
      context "where the includer already has a title" do
        it "should return that" do
          expect(ThingWithAllFieldsAndTitle.new.title).to eq("whev")
        end
      end
      context "where the includer does not have a title" do
        it "should return the full name" do
          expect(thing.title).to eq(thing.full_name)
        end
      end
    end
  end

end
