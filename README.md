# SmokeMonster

### Arrays to Objects

The purpose of this feature is to make the creation of a set of objects with data easy.

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
