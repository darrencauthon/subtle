# Subtle [![Build Status](https://secure.travis-ci.org/darrencauthon/subtle.png?branch=master)](http://travis-ci.org/darrencauthon/subtle)
[![Code Climate](https://codeclimate.com/github/darrencauthon/subtle.png)](https://codeclimate.com/github/darrencauthon/subtle)
[![Coverage Status](https://coveralls.io/repos/darrencauthon/subtle/badge.png?branch=master)](https://coveralls.io/r/darrencauthon/subtle)

This library contains methods that seem to cut down a litle bit of the code that I write daily.

## Usage

### Arrays to Objects

This feature exists to make the creation of sets of objects with data easily.

* Create an array of symbols that match the properties on the objects you want, and
* Pass a block that returns an array of arrays with matching data. 

````ruby
records = [:first_name, :last_name].to_objects { 
  [
    ["John", "Galt"], 
    ["Howard", "Roark"],
    ["Dagny", "Taggart"]
  ]}

records[0].first_name  # "John"
records[0].last_name   # "Galt"

records[1].first_name  # "Howard"
records[1].last_name   # "Roark"

records[2].first_name  # "Dagny"
records[2].last_name   # "Taggart"
````

### Arrays to Hashes

This feature exists to create a set of hashes with the same properties, but to only defined the keys once.

````ruby
records = [:first_name, :last_name].to_hashes {
  [
    ["John",   "Galt"   ],
    ["Howard", "Roark"  ],
    ["Dagny",  "Taggart"]
  ]}

records[0][:first_name]  # "John"
records[0][:last_name]   # "Galt"

records[1][:first_name]  # "Howard"
records[1][:last_name]   # "Roark"

records[2][:first_name]  # "Dagny"
records[2][:last_name]   # "Taggart"
````

### Array to Object

This feature exists to make the creation of an object with assignable properties easy.

* Create an array of symbols that match the properties you want on the object.

````ruby
person = [:first_name, :last_name].to_object

person.first_name = "John"
person.first_name # Will be John
person.last_name = "Galt"
person.last_name # Will be Galt
````

You can also pass an optional subject to to_object, and the properties will be added to that method.
````ruby
subject = ClassWithNoName.new
person = [:name].to_object subject

person.name = "John Galt"
person.name # Will be John Galt
````
### Safety Proc

This feature was written because I hate wrapping code in begin/rescue/end blocks.  If I have a line of code and I don't particularly care if it fails, I have to wrap it in three more lines of care to stop exceptions.

To me, this is most useful in import work or one-off processes where I might want to check to run a small block of code regardless of whether it fails.  This could lead to less code not just because of the lost begin/rescue/end lines, but because code can be written without concern of whether it will fail (nil checks, etc.).

````ruby
person.name = document.at_xpath('./h1').text

# if this call fails then we will move on
-> { person.bio = document.xpath('./div[@class="bio_info"]//span').text }.call_safely

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

person = Person.new(first_name: "John", last_name: "Galt")
````

You can also pass a block to the constructor when it is instantiated, like this:

````ruby
class Person
  params_constructor do
    @first_name = 'Howard'
  end
  attr_accessor :first_name, :last_name
end

person = Person.new(first_name: 'Dagny', last_name: 'Roark')

person.first_name #= Howard

````

or like this:

````ruby
class Person
  params_constructor
  attr_accessor :first_name, :last_name
end

person = Person.new(first_name: 'Dagny', last_name: 'Roark') do |p|
  p.first_name = 'Howard'
end

person.first_name #= Howard

````

### Lambda to Object

I was inspired to write this feature while dealing with some bad Rails code. A programmer wrote a before_filter on ApplicationController that made a big, expensive web service call to pass the users current weather information to the view.  This weather information was shown in various places on the site, but there were many pages on the site where the data was not being used at all.

A thought came to me... *would it be possible to create an object that does the work to instantiate itself, but only when it is referenced?*

Well, this doesn't quite do that, but it's close.  It lets you turn this:

````ruby
  before_filter do
    service = BigExpensiveWeatherService.new
    # we just paid the price right now
    @weather_results = service.an_expensive_web_call
  end
````

into this:

````ruby
  before_filter do
    # we haven't paid the price for this call
    @weather_results = -> do
      service = BigExpensiveWeatherService.new
      service.an_expensive_web_call
    end.to_object
  end
````

With both, you could do this:

````haml
  %span
    = @weather_results.temperature
````

But with the latter, the call to execute the big web service won't be made until .temperature is called.  Future calls to methods on @weather_results will use the same object passed from the Proc.




