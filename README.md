# SmokeMonster

````ruby
records = [:first_name, :last_name].to_objects { [["John", "Galt"], ["Howard", "Roark"]] }

records[0].first_name  # "John"
records[0].last_name   # "Galt"

records[1].first_name  # "Howard"
records[1].last_name   # "Roark"

````