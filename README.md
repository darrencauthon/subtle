# SmokeMonster

### Arrays to Objects

This feature exists to make the creation of sets of objects with data easily.

* Create an array of symbols of symbols that match the properties on the objects you want, and
* Pass a block that returns an array of arrays with matching data. 

````ruby
records = [:first_name, :last_name].to_objects { 
  [
    ["John", "Galt"], 
    ["Howard", "Roark"]
    ["Dagny", "Taggart"]
  ]}

records[0].first_name  # "John"
records[0].last_name   # "Galt"

records[1].first_name  # "Howard"
records[1].last_name   # "Roark"

records[2].first_name  # "Dagny"
records[2].last_name   # "Taggart"
````

### Safety Proc

This feature was written because I hate wrapping code in begin/rescue/end blocks.  If I have a line of code and I don't particularly care if it fails, I have to wrap it in three more lines of care to stop exceptions.

To me, this is most useful in imports or other code where I might want to check to run a small block of code that 

````ruby
person.name = document.at_xpath('./h1').text

# if this call fails then we will move on
-> { person.bio = document.xpath('./div[@class="bio_info"]//span') }.call_safely

# if this call fails then the second block will be called
-> { person.special = document.xpath('./div[@class="active"]//a')[1].text == "special" }.call_safely { person.special = false }
````

### Param Constructor

One thing I liked about C# was the ability to instantiate my objects like this:

````c#
var person = new Person() { FirstName = "John", LastName = "Galt" };
````

This syntax is not built into Ruby syntax today, but it does exist in Rails models.  So I took that idea from Rails and wrote an implementation that works like this:

````ruby
class Person
  params_constructor
  attr_accessor :first_name, :last_name
end

person = Person.new { first_name: "John", last_name: "Galt" }
````

