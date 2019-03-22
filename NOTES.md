# Notes

## Todos

- [ ]  allow / add support equal `==` by integer or symbol - why? why not? e.g.

``` ruby
color == :red    #=> ???
color == 0       #=> ???
```

or always use color == `Color.red` ???




## Enums in Ruby

No library needed, just use symbols :-) e.g.

``` ruby
Color = [:red, :blue, :green]
Color[0]  #=> :red
Color[1]  #=> :blue

# -or-
Color = {red: 0, blue: 1, green: 2}
Color[:red]   #=> 0
Color[:blue]  #=> 1

Weekday = [:mon, :tue, :wed, :thu, :fri, :sat, :sun]
Weekday[0]  #=> :mon
```

Why? Why not? Discuss.

Search Rubygems <https://rubygems.org/search?query=enum>


## Enums in Crystal



## Enums in Python

Robust enumerated type support in Python  - *RETIRED*, see (new) enum Data Type in Standard Library
<https://pypi.org/project/enum>

The Python Standard Library - enum Data Type - Support for Enumeration in Python 3+
<https://docs.python.org/3/library/enum>
