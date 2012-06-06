require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "arrays to objects" do

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
  end
  
end
