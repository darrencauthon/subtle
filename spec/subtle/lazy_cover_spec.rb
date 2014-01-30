require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class LazyCoverTest
  class << self
    attr_accessor :was_called
  end
end

describe Subtle::LazyCover do

  it "should not call the block passed to it" do
    lazy = Subtle::LazyCover.new(lambda { raise 'was called' })
  end

  it "should call the block passed to it when things are references" do
    LazyCoverTest.was_called = false
    lazy = Subtle::LazyCover.new(lambda { LazyCoverTest.was_called = true })
    LazyCoverTest.was_called.must_equal false
    lazy.to_s
    LazyCoverTest.was_called.must_equal true
  end

  it "should call the block passed to it only once" do
    LazyCoverTest.was_called = 0
    lazy = Subtle::LazyCover.new(lambda { LazyCoverTest.was_called = LazyCoverTest.was_called + 1 })
    LazyCoverTest.was_called.must_equal 0
    lazy.to_s
    LazyCoverTest.was_called.must_equal 1
    lazy.to_s
    LazyCoverTest.was_called.must_equal 1
  end

  it "should return the same exceptions passed from its base class methods" do

    object = Object.new
    object.stubs(:defined_method).returns("yes")

    lazy = Subtle::LazyCover.new(lambda { object })
    lazy.defined_method.must_equal "yes"
    was_called = false
    begin
      lazy.not_a_defined_method
    rescue NoMethodError
      was_called = true
    end
    was_called.must_equal true
  end

  describe "the original subject" do
    it "should call the block passed to it" do
      Subtle::LazyCover.new(lambda { 0 }).the_original_subject.must_equal 0
      Subtle::LazyCover.new(lambda { "x" }).the_original_subject.must_equal "x"
    end

    it "should only call the block passed to it once" do
      LazyCoverTest.was_called = 0
      lazy = Subtle::LazyCover.new(lambda { LazyCoverTest.was_called += 1 })
      lazy.the_original_subject
      LazyCoverTest.was_called.must_equal 1
      lazy.the_original_subject
      LazyCoverTest.was_called.must_equal 1
    end
  end

end
