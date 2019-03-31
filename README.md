# Enums - Safe Enumeration Types

enums library / gem - safe enum / enumeration types - a set of symbolic keys bound to unique integer numbers (incl. bit flags option)

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
Color::RED       #=> 0
Color::BLUE      #=> 1
Color.constants  #=> [:RED, :BLUE, :GREEN]
# ...
```

Why? Why not? Discuss.


## Usage

``` ruby
Enum.new( :Color, :red, :green, :blue )
# or
enum :Color, :red, :green, :blue
# or
enum :Color, [:red, :green, :blue]
# or
enum :Color, { red:   0,
               green: 1,
               blue:  2 }

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

  def self.zero() members[0]; end

  def self.value( value )
    @hash_by_value ||= Hash[ values.zip( members ) ]
    @hash_by_value[ value ]
  end

  def self.key( key )
    @hash_by_key ||= Hash[ keys.zip( members ) ]
    @hash_by_key[ key ]
  end
  def self.[]( key ) self.key( key ); end

  def red?()   self == RED; end
  def blue?()  self == BLUE; end
  def green?() self == GREEN; end
end


def Color( index )
  Color.members[ index ]
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
Color.size           #=> 3
Color.length         #=> same as Color.size
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
Enum.new( :State, :fundraising, :expired_refund, :successful )
# or
enum :State, :fundraising, :expired_refund, :successful
# or
enum :State, [:fundraising, :expired_refund, :successful]
# or
enum :State, { fundraising:    0,
               expired_refund: 1,
               successful:     2 }


State.values  #=> [0, 1, 2]
State.keys    #=> [:fundraising, :expired_refund, :successful]
State.size    #=> 3
State.length  #=> same as State.size

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
state.is_a? Enum         #=> true
state.is_a? State        #=> true

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




### What about enums with flags and bitwise-operators for set (`|`) / unset (`&~`) / toggle (`^`)?

Use the `flags` option or the `Flag` class. Example:

``` ruby
Flag.new( :FileAttrib, :read_only, :hidden, :system, :archive )
# -or -
enum :FileAttrib, [:read_only, :hidden, :system, :archive], flags: true
# -or -
enum :FileAttrib, :read_only, :hidden, :system, :archive, flags: true
# -or -
enum :FileAttrib, { read_only: Bit(0),
                    hidden:    Bit(1),
                    system:    Bit(2),
                    archive:   Bit(5),
                  },
                  flags: true
```

Aside: What's `Bit()`?

`Bit()` is a bit conversion helper defined as `def Bit(n) 1 << n; end`. Example:

|           | Bit Shift  | Binary        | Decimal     | Hex     |
|-----------|------------|---------------|-------------|---------|
| `Bit(0)`  |   `1<<0`   |  `0b00000001` |  `2^0 = 1`  |  `0x01` |
| `Bit(1)`  |   `1<<1`   |  `0b00000010` |  `2^1 = 2`  |  `0x02` |
| `Bit(2)`  |   `1<<2`   |  `0b00000100` |  `2^2 = 4`  |  `0x04` |
| `Bit(3)`  |   `1<<3`   |  `0b00001000` |  `2^3 = 8`  |  `0x08` |
| `Bit(4)`  |   `1<<4`   |  `0b00010000` |  `2^4 = 16` |  `0x10` |
| `Bit(5)`  |   `1<<5`   |  `0b00100000` |  `2^5 = 32` |  `0x20` |
| ...       |



(Auto-)builds a class and code like:

``` ruby
class Flag
  def initialize( key, value )
    @key   = key
    @value = value
  end
end


class FileAttrib < Flag

  NONE      = new( :none,      0    )
  READ_ONLY = new( :read_only, Bit(0) )
  HIDDEN    = new( :hidden,    Bit(1) )
  SYSTEM    = new( :system,    Bit(2) )
  ARCHIVE   = new( :archive,   Bit(3) )
  ALL       = new( :all,       Bit(0)|Bit(1)|Bit(2)|Bit(3) )

  def self.none()      NONE; end
  def self.read_only() READ_ONLY; end
  def self.hidden()    HIDDEN; end
  def self.system()    SYSTEM; end
  def self.archive()   ARCHIVE; end
  def self.all()       ALL; end

  def self.values()  [Bit(0),Bit(1),Bit(2),Bit(3)]; end
  def self.keys()    [:read_only, :hidden, :system, :archive]; end
  def self.members() [READ_ONLY, HIDDEN, SYSTEM, ARCHIVE]; end

  def self.zero() NONE; end

  def self.key( key )
    @hash_by_key ||= Hash[ keys.zip( members ) ]
    @hash_by_key[ key ]
  end
  def self.[]( key ) self.key( key ); end

  def none?         @value == 0; end
  def read_only?()  @value & Bit(0) == Bit(0); end
  def hidden?()     @value & Bit(1) == Bit(1); end
  def system?()     @value & Bit(2) == Bit(2); end
  def archive?()    @value & Bit(3) == Bit(3); end
  def all?()        @value == Bit(0)|Bit(1)|Bit(2)|Bit(3); end

  def member?( other ) @value & other.value == other.value; end

  def bitwise_or( other )
    self.class.new( @value | other.value )
  end
  alias_method :|,    :bitwise_or
  alias_method :set,  :bitwise_or
  alias_method :flag, :bitwise_or

  def bitwise_and( other )
    self.class.new( @value & other.value )
  end
  alias_method :&, :bitwise_and

  def unset( other )
    self.class.new( @value & ~other.value )
  end
  alias_method :unflag, :unset

  def bitwise_xor( other )
    self.class.new( @value ^ other.value )
  end
  alias_method :^,      :bitwise_xor
  alias_method :toggle, :bitwise_xor

  # ...
end


def FileAttrib( *args )
  FileAttrib.convert( *args )
end
```

Use like:

``` ruby
FileAttrib.values  #=> [1, 2, 4, 8]
FileAttrib.keys    #=> [:read_only, :hidden, :system, :archive]

FileAttrib.read_only                      #=> <FileAttrib @key=:read_only, @value=1>
FileAttrib::READ_ONLY                     #=> <FileAttrib @key=:read_only, @value=1>
FileAttribs[:read_only]                    #=> <FileAttrib @key=:read_only, @value=1>

FileAttrib(0)                             #=> <FileAttrib @key=:none, @value=0>
FileAttrib.read_only | FileAttrib.hidden  #=> <FileAttrib @key=:0011, @value=3>
# -or-
FileAttrib( FileAttrib.read_only | FileAttrib.hidden )
FileAttrib( FileAttrib::READ_ONLY | FileAttrib::HIDDEN )
FileAttrib( :read_only, :hidden )
#=> <FileAttrib @key=:0011, @value=3>

attrib  = FileAttrib.none       #=> <FileAttrib @key=:none, @value=0>
attrib |= FileAttrib.read_only  #=> <FileAttrib @key=:read_only, @value=1>
attrib.read_only?               #=> true
# -or-
attrib.member?( FileAttrib.read_only )                #=> true
attrib.member?( FileAttrib.READ_ONLY )                #=> true
attrib.member?( :read_only )                          #=> true
attrib & FileAttrib.read_only == FileAttrib.read_only #=> true

attrib ^= FileAttrib.read_only  #=> <FileAttrib @key=:none, @value=0>
attrib.read_only?               #=> false
attrib ^= FileAttrib.read_only  #=> <FileAttrib @key=:read_ony, @value=1>
attrib.read_only?               #=> true

attrib &= ~FileAttrib.read_only #=> <FileAttrib @key=:none, @value=0>
attrib.read_only?               #=> false

attrib.is_a? Flag               #=> true
attrib.is_a? FileAttrib         #=> true
# ...
```


Let's try another example:

``` ruby
Flag.new( :TextStyle, :bold, :italic, :underline )
# -or -
enum :TextStyle, [:bold, :italic, :underline], flags: true
# -or -
enum :TextStyle, :bold, :italic, :underline, flags: true
# -or -
enum :TextStyle, { bold:      Bit(0),
                   italic:    Bit(1),
                   underline: Bit(2)
                 },
                 flags: true


TextStyle.values  #=> [1, 2, 4]
TextStyle.keys    #=> [:bold, :italic, :underline]

TextStyle.bold                      #=> <TextStyle @key=:bold, @value=1>
TextStyle::BOLD                     #=> <TextStyle @key=:bold, @value=1>
TextStyle[:bold]                    #=> <TextStyle @key=:bold, @value=1>

TextStyle(0)                        #=> <TextStyle @key=:none, @value=0>
TextStyle.bold | TextStyle.italic   #=> <TextStyle @key=:0011, @value=3>
# -or-
TextStyle( TextStyle.bold | TextStyle.italic )
TextStyle( TextStyle::BOLD | TextStyle::ITALIC )
TextStyle( :bold, :italic )
#=> <TextStyle @key=:0011, @value=3>

style  = TextStyle.none   #=> <TextStyle @key=:none, @value=0>
style |= TextStyle.bold   #=> <TextStyle @key=:bold, @value=1>
style.bold?               #=> true
# -or-
style.member?( TextStyle.bold )             #=> true
style.member?( TextStyle.BOLD )             #=> true
style.member?( :bold )                      #=> true
style & TextStyle.bold == TextStyle.bold    #=> true

style ^= TextStyle.bold   #=> <TextStyle @key=:none, @value=0>
style.bold?               #=> false
style ^= TextStyle.bold   #=> <TextStyle @key=:bold, @value=1>
style.bold?               #=> true

style &= ~TextStyle.bold  #=> <TextStyle @key=:none, @value=0>
style.bold?               #=> false

style = TextStyle.bold | TextStyle.italic | TextStyle.underline
#=> <TextStyle @key=:all, @value=7>
style & TextStyle.all == TextStyle.all  #=> true
style & TextStyle.all != 0              #=> true
style.all?                              #=> true

style.is_a? Flag          #=> true
style.is_a? TextStyle     #=> true
# ...
```

and so on.




### What about enums for (algebraic) union data types with variants?

Yes, yes, yes. Use the `Union` class or the `data` helper from the safedata library.
Note, now you can go "wild" and use strings, arrays or really anything or nothing (that is, unit types) for your values. Example:

``` ruby
data :Color, :Red, [1],
             :Green, [2],
             :Blue, [3]

# -or-

data :Color, :Red, ['red'],
             :Green, ['green'],
             :Blue, ['blue']

# -or-

data :Color, :Red, [1,'red'],
             :Green, [2, 'green'],
             :Blue, [3, 'blue']

# -or-

data :Color, :Red, [255, 0, 0],
             :Green, [0, 255, 0],
             :Blue, [0, 0, 255],
             :Other, [:r, :g, :b]
```

and so on and so forth.
See the [safedata library documentation for more »](https://github.com/s6ruby/safedata)




## More "Real World" Enum Samples

- [The "Red Paper" about sruby](https://github.com/s6ruby/redpaper) - Small, Smart, Secure, Safe, Solid & Sound (S6) Ruby - The Ruby Programming Language for Contract / Transaction Scripts on the Blockchain World Computer - Yes, It's Just Ruby
- [Ruby Sample Contracts for the Universum Blockchain/World Computer Runtime](https://github.com/s6ruby/universum-contracts)


## More Safe Data Structures (Array, Hash, Struct)

[Safe Data Structures (Array, Hash, Struct)](https://github.com/s6ruby/safestruct) - Say goodbye to null / nil (and maybe) and the Billion-Dollar mistake. Say hello to zero and the Billon-Dollar fix.



## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The `enums` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the [wwwmake forum](http://groups.google.com/group/wwwmake).
Thanks!
