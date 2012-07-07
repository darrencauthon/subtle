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

end
