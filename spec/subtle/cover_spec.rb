require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subtle::Cover do
  before do
  end

  describe "when given an Object" do
    before do
      @view_model = Subtle::Cover.new Object.new
    end

    it "should not throw an exception on methods that do not exist" do
      @view_model.not_this
      @view_model.or_this_either
    end

    it "should return an object if the method does not exist" do
      @view_model.should_be_a_view_model.wont_be_nil
      @view_model.another_test.wont_be_nil
    end

    it "should return new view models each time on methods that do not exist" do
      first = @view_model.one_call
      second = @view_model.second_call

      first.object_id.wont_equal @view_model.object_id
      second.object_id.wont_equal @view_model.object_id
      first.object_id.wont_equal second.object_id
    end
  end

  describe "when given a Person object" do
    class Person
      attr_accessor :first_name, :last_name
    end

    before do
      @person = Person.new
      @view_model = Subtle::Cover.new @person
    end

    [["John", "Galt"], ["Howard", "Roark"]].each do |name|
      describe "with name of #{name[0]} #{name[1]}" do
        before do
          @person.first_name = name[0]
          @person.last_name = name[1]
        end

        it "should return John as the first name" do
          @view_model.first_name.must_equal name[0]
        end

        it "should return Galt as the last name" do
          @view_model.last_name.must_equal name[1]
        end
      end
    end
  end

  describe "when given an object that uses a block" do
    class Thing
      class << self
        attr_accessor :test_value
      end
      def test(&blk)
        blk.call
      end
    end

    before do
      @thing = Thing.new
      @view_model = Subtle::Cover.new @thing
    end

    it "should call the block" do
      @view_model.test do
        Thing.test_value = true
      end
      Thing.test_value.must_equal true
    end
  end

  [1, "abc", Object.new].each do |subject|
    describe "#the_original_subject" do
      before do
        @cover = Subtle::Cover.new subject
      end

      it "should return the original" do
        @cover.the_original_subject.must_equal subject
      end
    end
  end
end
