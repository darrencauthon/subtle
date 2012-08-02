require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module SafetyProc
  class << self
    attr_accessor :called
  end
end

describe "Safety Proc" do
  describe "a proc that will throw an exception" do
    before do
      SafetyProc.called = false
      @proc = -> do 
        SafetyProc.called = true
        raise 'k'
      end
    end

    it "should trap the exception yet still call the method" do
      @proc.call_safely
      SafetyProc.called.must_equal true
    end
  end

  describe "a proc with a block to call on error" do
    before do
      SafetyProc.called = false
    end

    it "call the block" do
      @proc = -> { raise 'k' }.call_safely { SafetyProc.called = true }
      SafetyProc.called.must_equal true
    end
  end
end
