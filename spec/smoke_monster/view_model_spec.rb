require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SmokeMonster::ViewModel do
  before do
  end

  describe "when given an Object" do
    before do
      @view_model = SmokeMonster::ViewModel.new Object.new
    end

    it "should not throw an exception on methods that do not exist" do
      @view_model.not_this
      @view_model.or_this_either
    end
  end
end
