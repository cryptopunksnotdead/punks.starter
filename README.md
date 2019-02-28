# Enums - Safe Enumeration Types

enums library / gem - safe enumeration types - a set of symbolic keys bound to unique integer numbers

* home  :: [github.com/s6ruby/enums](https://github.com/s6ruby/enums)
* bugs  :: [github.com/s6ruby/enums/issues](https://github.com/s6ruby/enums/issues)
* gem   :: [rubygems.org/gems/enums](https://rubygems.org/gems/enums)
* rdoc  :: [rubydoc.info/gems/enums](http://rubydoc.info/gems/enums)


##  Why `enums` in Ruby?

No library needed, just use symbols :-) or use constants. Example:

``` ruby
Color = [:red, :blue, :green]
Color[0]  #=> :red
Color[1]  #=> :blue

# -or-

Color = {red: 0, blue: 1, green: 2}
Color[:red]   #=> 0
Color[:blue]  #=> 1
Color.keys    #=> [:red, :blue, :green]
Color.values  #=> [0, 1, 2]

# -or-

module Color
  RED   = 0
  BLUE  = 1
  GREEN = 2
end
Color::RED   #=> 0
Color::BLUE  #=> 1
Color.constants  #=> [:RED, :BLUE, :GREEN]
# ...
```

Why? Why not? Discuss.


## Usage

``` ruby
Enum.new( 'Color', :red, :green, :blue )
```

(Auto-)builds a class and code like:

``` ruby
class Enum
  def initialize( key, value )
    @key   = key
    @value = value
  end
end

class Color < Enum

  RED   = new(:red,   0)
  BLUE  = new(:blue,  1)
  GREEN = new(:green, 2)

  def self.red()   RED; end
  def self.blue()  BLUE; end
  def self.green() GREEN; end

  def self.values()  [0,1,2]; end
  def self.keys()    [:red, :blue, :green]; end
  def self.members() [RED, BLUE, GREEN]; end

  def self.value( index ) @members[index]; end
  def self.zero() value(0); end

  def self.key( key )
    @hash ||= Hash[ keys.zip( members ) ]
    @hash[ key ]
  end
  def self.[]( key )  self.key( key ); end

  def red?()   self == RED; end
  def blue?()  self == BLUE; end
  def green?() self == GREEN; end
end

def Color( arg )
  Color.value( arg )
end
```


Use like:

``` ruby
Color::RED           #=> <Color @key=:red, @value=0>
Color(0)             #=> Color::RED -or- <Color @key=:red, @value=0>
Color.zero           #=> same as Color(0)
Color.red            #=> Color::RED
Color.values         #=> [0, 1, 2]
Color.keys           #=> [:red, :green, :blue]
Color.members        #=> [RED, GREEN, BLUE]
                     #    -or-
                     #   [<Color @key=:red,   @value=0>,
                     #    <Color @key=:green, @value=1>,
                     #    <Color @key=:blue,  @value=2>]
Color(1)             #=> Color::GREEN
Color.value(1)       # same as Color(1)
Color[:red]          #=> Color::RED
Color.key(:red)      # same as Color[:red]
color = Color.red
color.red?           #=> true
color == Color.red   #=> true
color.value          #=> 0
color.key            #=> :red
color.blue?          #=> false
color == Color.blue  #=> false
color.is_a? Enum     #=> true
color.is_a? Color    #=> true
...
```

Let's try another example:

``` ruby
Enum.new( 'State', :fundraising, :expired_refund, :successful )

State.values  #=> [0, 1, 2]
State.keys    #=> [:fundraising, :expired_refund, :successful]

State.members            #=> [FUNDRAISING, EXPIRED_REFUND, SUCCESSFUL]
                         #    -or-
                         #   [<State @key=:fundraising,    @value=0>,
                         #    <Safe  @key=:expired_refund, @value=1>,
                         #    <State @key=:successful,     @value=2>]
State.members[0].key     #=> :fundraising
State.members[0].value   #=> 0
State.members[1].key     #=> :expired_refund
State.members[1].value   #=> 1

State.fundraising.value  #=> 0
State.fundraising.key    #=> :fundraising
State::FUNDRAISING.value #=> 0
State::FUNDRAISING.key   #=> :fundraising

state = State.fundraising
state.fundraising?       #=> true
state.value              #=> 0

State(0)                 #=> State::FUNDRAISING
State(1)                 #=> State::EXPIRED_REFUND
State(2)                 #=> State::SUCCESSFUL

State.zero               # same as State(0)
State(0) == State.zero   #=> true
State(1) == State.zero   #=> false

State.value(0)           #=> State::FUNDRAISING
State[:fundraising]      #=> State::FUNDRAISING
State.key(:fundraising)  # same as State[:fundraising]
# ...
```

and so on.



## More "Real World" Enum Samples

- [The "Red Paper" about sruby](https://github.com/s6ruby/redpaper) - Small, Smart, Secure, Safe, Solid & Sound (S6) Ruby - The Ruby Programming Language for Contract / Transaction Scripts on the Blockchain World Computer - Yes, It's Just Ruby
- [Ruby Sample Contracts for the Universum Blockchain/World Computer Runtime](https://github.com/s6ruby/universum-contracts)


## More Safe Data Structure (Array, Hash, Struct)

[Safe Data Structures (Array, Hash, Struct)](https://github.com/s6ruby/safestruct) - Say goodbye to null / nil (and maybe) and the Billion-Dollar mistake. Say hello to zero and the Billon-Dollar fix.



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `enums` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
