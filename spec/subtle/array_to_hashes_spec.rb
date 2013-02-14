require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "arrays to hashes" do

  describe "creating hashes with matching attr_accessors and values" do
    [:name, :street].each do |property|
      describe "with an array with one symbol named #{property.to_s}" do
        describe "and no data" do
          before do
            @values = [property].to_hashes { [] }
          end

          it "should return an empty array" do
            @values.must_be_empty
          end
        end

        ["Dangy", "Taggart"].each do |name|
          describe "and one record with #{name}" do
            before do
              @values = [property].to_hashes { [name] }
            end

            it "should return one record" do
              @values.count.must_equal 1
            end

            it "should have a property with the name of Dangy" do
              @values[0][property].must_equal name
            end
          end
        end

        describe "and two records with John and Howard" do
          before do
            @values = [property].to_hashes {["John", "Howard"]}
          end

          it "should return two records" do
            @values.count.must_equal 2
          end

          it "should set the first to John" do
            @values[0][property].must_equal "John" 
          end

          it "should set the second to Howard" do
            @values[1][property].must_equal "Howard"
          end
        end
      end

      describe "with an array with two symbols named first_name and last_name" do
        describe "with 'Ellis' and 'Wyatt'" do
          before do
            @values = [:first_name, :last_name].to_hashes { [['Ellis', 'Wyatt']] }
          end

          it "should return one record" do
            @values.count.must_equal 1
          end

          it "should set the first name to Ellis" do
            @values[0][:first_name].must_equal 'Ellis'
          end

          it "should set the last name to Wyatt" do
            @values[0][:last_name].must_equal 'Wyatt'
          end
        end

        describe "with 'Ellis' and 'Wyatt', then 'Dagny' and 'Taggart'" do
          before do
            @values = [:first_name, :last_name].to_hashes { [['Ellis', 'Wyatt'], ['Dagny', 'Taggart']] }
          end

          it "should return one record" do
            @values.count.must_equal 2
          end

          it "should set the first name to Ellis on the first record" do
            @values[0][:first_name].must_equal 'Ellis'
          end

          it "should set the last name to Wyatt on the first record" do
            @values[0][:last_name].must_equal 'Wyatt'
          end

          it "should set the first name to Dagny on the second record" do
            @values[1][:first_name].must_equal 'Dagny'
          end

          it "should set the last name to Wyatt on the second record" do
            @values[1][:last_name].must_equal 'Taggart'
          end
        end
      end
    end
  end
end
