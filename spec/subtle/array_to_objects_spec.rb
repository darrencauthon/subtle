require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "arrays to objects" do

  describe "creating objects with matching attr_accessors and values" do
    [:name, :street].each do |property|
      describe "with an array with one symbol named #{property.to_s}" do
        describe "and no data" do
          before do
            @values = [property].to_objects { [] }
          end

          it "should return an empty array" do
            @values.must_be_empty
          end
        end

        ["Dangy", "Taggart"].each do |name|
          describe "and one record with #{name}" do
            before do
              @values = [property].to_objects { [name] }
            end

            it "should return one record" do
              @values.count.must_equal 1
            end

            it "should have a property with the name of Dangy" do
              @values[0].send(property).must_equal name
            end
          end
        end

        describe "and two records with John and Howard" do
          before do
            @values = [property].to_objects {["John", "Howard"]}
          end

          it "should return two records" do
            @values.count.must_equal 2
          end

          it "should set the first to John" do
            @values[0].send(property).must_equal "John" 
          end

          it "should set the second to Howard" do
            @values[1].send(property).must_equal "Howard"
          end
        end
      end

      describe "with an array with two symbols named first_name and last_name" do
        describe "with 'Ellis' and 'Wyatt'" do
          before do
            @values = [:first_name, :last_name].to_objects { [['Ellis', 'Wyatt']] }
          end

          it "should return one record" do
            @values.count.must_equal 1
          end

          it "should set the first name to Ellis" do
            @values[0].first_name.must_equal 'Ellis'
          end

          it "should set the last name to Wyatt" do
            @values[0].last_name.must_equal 'Wyatt'
          end
        end

        describe "with 'Ellis' and 'Wyatt', then 'Dagny' and 'Taggart'" do
          before do
            @values = [:first_name, :last_name].to_objects { [['Ellis', 'Wyatt'], ['Dagny', 'Taggart']] }
          end

          it "should return one record" do
            @values.count.must_equal 2
          end

          it "should set the first name to Ellis on the first record" do
            @values[0].first_name.must_equal 'Ellis'
          end

          it "should set the last name to Wyatt on the first record" do
            @values[0].last_name.must_equal 'Wyatt'
          end

          it "should set the first name to Dagny on the second record" do
            @values[1].first_name.must_equal 'Dagny'
          end

          it "should set the last name to Wyatt on the second record" do
            @values[1].last_name.must_equal 'Taggart'
          end
        end
      end
    end
  end

  class TestObject
    attr_accessor :city, :state, :zip
  end

  describe 'creating objects of a certain type' do
    describe 'when attr_accessor exists for each property' do
      before do
        @results = [:city, :state, :zip].to_objects(TestObject) {[
                     ['Olathe', 'KS', '66061'], ['Kansas City', 'MO', '64125']
                   ]}
      end

      it "should return objects of the type provided" do
        @results[0].class.must_equal TestObject
      end

      it "should set the properties as expected" do
        @results[0].city.must_equal 'Olathe'
        @results[0].state.must_equal 'KS'
        @results[0].zip.must_equal '66061'
        @results[1].city.must_equal 'Kansas City'
        @results[1].state.must_equal 'MO'
        @results[1].zip.must_equal '64125'
      end
    end
  end

  describe 'when attr_accessor does not exist for each property' do
    it "should throw an exception" do
      error_thrown = false
      begin
        [:something_that_does_not_exist].to_objects(TestObject) {[
           ['value']
        ]}
      rescue
        error_thrown = true
      end
      error_thrown.must_equal true
    end
  end
end
