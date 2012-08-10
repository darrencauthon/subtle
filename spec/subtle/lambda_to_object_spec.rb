require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "lambda to object" do

  describe "to_object on a lambda that returns nil" do
    before do
      @value = lambda { nil }.to_object
    end

    it "should remember the original value is nil" do
      @value.the_original_subject.must_equal nil 
    end
  end

  describe "to_object on a lambda that returns an integer" do
    before do
      @value = lambda { 1 }.to_object
    end

    it "should remember the original value is 1" do
      @value.the_original_subject.must_equal 1
    end

    it "should be able to use the value as an integer" do
      (@value + 1).must_equal 2
    end
  end

  describe "to_object on a lambda, but never accessing the variable" do
    before do
      @was_called = false
      @value = lambda { raise 'it was called' }.to_object
    end

    it "should not be called" do
      #will throw an exception if it was called above 
    end
  end
end
