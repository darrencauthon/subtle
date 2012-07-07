require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SmokeMonster::LazyCover do

  it "should not call the block passed to it" do
    lazy = SmokeMonster::LazyCover.new -> { raise 'was called' }
  end

end
