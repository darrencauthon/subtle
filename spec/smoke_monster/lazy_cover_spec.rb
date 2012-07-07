require 'mocha'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class LazyCoverTest
  class << self
    attr_accessor :was_called
  end
end
describe SmokeMonster::LazyCover do

  it "should not call the block passed to it" do
    lazy = SmokeMonster::LazyCover.new(-> { raise 'was called' })
  end

  it "should call the block passed to it when things are references" do
    LazyCoverTest.was_called = false
    lazy = SmokeMonster::LazyCover.new(-> { LazyCoverTest.was_called = true })
    LazyCoverTest.was_called.must_equal false
    lazy.to_s
    LazyCoverTest.was_called.must_equal true
  end

  it "should call the block passed to it only once" do
    LazyCoverTest.was_called = 0
    lazy = SmokeMonster::LazyCover.new(-> { LazyCoverTest.was_called = LazyCoverTest.was_called + 1 })
    LazyCoverTest.was_called.must_equal 0
    lazy.to_s
    LazyCoverTest.was_called.must_equal 1
    lazy.to_s
    LazyCoverTest.was_called.must_equal 1
  end

  it "should return the same exceptions passed from its base class methods" do

    object = Object.new
    def object.defined_method
      "yes"
    end

    lazy = SmokeMonster::LazyCover.new(-> { object })
    lazy.defined_method.must_equal "yes"
    was_called = false
    begin
      lazy.not_a_defined_method
    rescue
      was_called = true
    end
    was_called.must_equal true
  end

  describe "the original subject" do
    it "should call the block passed to it" do
      SmokeMonster::LazyCover.new(-> { 0 }).the_original_subject.must_equal 0
      SmokeMonster::LazyCover.new(-> { "x" }).the_original_subject.must_equal "x"
    end

    it "should only call the block passed to it once" do
      LazyCoverTest.was_called = 0
      lazy = SmokeMonster::LazyCover.new(-> { LazyCoverTest.was_called += 1 })
      lazy.the_original_subject
      LazyCoverTest.was_called.must_equal 1
      lazy.the_original_subject
      LazyCoverTest.was_called.must_equal 1
    end
  end

end
