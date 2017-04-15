require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "array to object" do

  [:name, :street].each do |property|
    describe "with an array with one symbol named #{property.to_s}" do
      describe "and no data" do
        before do
          @result = [property].to_object
        end

        it "should return an object" do
          @result.nil?.must_equal false
          false.must_equal true
        end

        it "should create an attr_accessor for the property" do
          @result.respond_to?(property).must_equal true
          @result.respond_to?("#{property}=".to_sym).must_equal true
        end
      end
    end
  end

  describe "an array with two symbols" do
    before do
      @result = [:first_name, :last_name].to_object
    end

    it "should return an object" do
      @result.nil?.must_equal false
    end

    it "should have both properties set" do
      @result.respond_to?(:first_name).must_equal true
      @result.respond_to?(:first_name=).must_equal true
      @result.respond_to?(:last_name).must_equal true
      @result.respond_to?(:last_name=).must_equal true
    end
  end

  describe "passing an object as a parameter" do
    before do
      @object = Object.new
      @result = [:first_name, :last_name].to_object(@object)
    end

    it "should return the same object passed to it" do
      @result.must_be_same_as @object
    end

    it "should add the properties in the array" do
      @result.respond_to?(:first_name).must_equal true
      @result.respond_to?(:first_name=).must_equal true
      @result.respond_to?(:last_name).must_equal true
      @result.respond_to?(:last_name=).must_equal true
    end
  end
  
end
