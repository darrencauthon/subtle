require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class ParamConstructorTest
  param_constructor
  attr_accessor :first_name, :last_name
end

class SecondParamConstructorTest
  param_constructor
  attr_accessor :first_name, :last_name
end

describe "param_constructor" do
  describe 'just the constructor itself' do
    it "should let the object be instantiated with a hash" do
      test = ParamConstructorTest.new(first_name: "John", last_name: "Galt")
      test.first_name.must_equal "John"
      test.last_name.must_equal "Galt"
    end

    it "should allow the object to be instantiated with no params" do
      test = ParamConstructorTest.new
      # should not throw an error
    end
  end

  describe 'pass a block to the constructor' do
    it "should let the object be instantiated with a hash" do
      test = SecondParamConstructorTest.new(first_name: "Dagny", last_name: "Roark") do |o|
        o.first_name = 'Howard'
      end
      test.first_name.must_equal 'Howard'
      test.last_name.must_equal 'Roark'
    end
  end
end
