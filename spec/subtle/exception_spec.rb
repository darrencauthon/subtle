require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "exception returning" do

  ['uh oh', 'another error'].each do |message|

    describe "a runtime exception" do

      it "should return a runtime exception" do
        exception = (->() { raise message }).exception_raised
        exception.is_a?(RuntimeError).must_equal true
        exception.message.must_equal message
      end

    end

    describe "no runtime exception" do

      it "should return a runtime exception" do
        exception = (->() { message }).exception_raised
        exception.nil?.must_equal true
      end

    end

  end
end
