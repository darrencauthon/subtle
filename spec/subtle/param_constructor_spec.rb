require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class ParamConstructorTest
  param_constructor
  attr_accessor :first_name, :last_name
end

class SecondParamConstructorTest
  param_constructor
  attr_accessor :first_name, :last_name
end

class ThirdParamConstructorTest
  param_constructor { |p| p.first_name = "expected value" }
  attr_accessor :first_name, :last_name
end

class FourthParamConstructorTest
  param_constructor do |p|
    p.middle_name = 'm'
    p.first_name = 'f'
    p.last_name = 'l'
  end
  attr_accessor :first_name, :last_name, :middle_name
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

  describe 'pass a block with the constructor' do
    it "should let the object be instantiated with a hash" do
      test = ThirdParamConstructorTest.new(first_name: "Dagny", last_name: "Roark")
      test.first_name.must_equal 'expected value'
    end
  end

  describe 'pass a block with the constructor AND to the constructor' do
    it "should run both and let the last one win" do
      test = FourthParamConstructorTest.new(first_name: "", last_name: "") do |o|
        o.last_name = "second"
        o.first_name = "first"
      end
      test.first_name.must_equal 'first'
      test.last_name.must_equal 'second'
      test.middle_name.must_equal 'm'
    end
  end
end
