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

    it "should return a view model if the method does not exist" do
      @view_model.should_be_a_view_model.must_be_instance_of SmokeMonster::ViewModel
      @view_model.another_test.must_be_instance_of SmokeMonster::ViewModel
    end

    it "should return new view models each time on methods that do not exist" do
      first = @view_model.one_call
      second = @view_model.second_call

      first.object_id.wont_equal @view_model.object_id
      second.object_id.wont_equal @view_model.object_id
      first.object_id.wont_equal second.object_id
    end
  end
end
