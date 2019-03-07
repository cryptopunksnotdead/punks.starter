# encoding: utf-8

## stdlibs
require 'pp'


## our own code
require 'enums/version'    # note: let version always go first

##################################
## auto-create/builds enum class.
##
## Example:
##   State = Enum.new( :fundraising, :expired_refund, :successful)
##     auto-creates/builds:
##
##  class Enum
##    def initialize( key, value )
##      @key   = key
##      @value = value
##    end
##  end
##
##  class State < Enum
##
##    FUNDRAISING    = new(:fundraising,    0)
##    EXPIRED_REFUND = new(:expired_refund, 1)
##    SUCCESSFUL     = new(:successful,     2)
##
##    def self.fundraising()    FUNDRAISING; end
##    def self.expired_refund() EXPIRED_REFUND; end
##    def self.successful()     SUCCESSFUL; end
##
##    def fundraising?()     self == FUNDRAISING; end
##    def expired_refund?()  self == EXPIRED_REFUND; end
##    def successful?()      self == SUCCESSFUL; end
##  end
##
##  pp state = State.fundraising     #=> #<State @key=:fundraising, @value=0>
##  pp state.fundraising?            #=> true
##  pp state.expired_refund?         #=> false
##  pp state.successful?             #=> false
##  pp state = State.expired_refund  #=> #<State @key=:expired_refund, @value=1>
##  pp state.fundraising?            #=> false
##  pp state.expired_refund?         #=> true
##  pp state.successful?             #=> false


module Safe

## note: use ClassMethods pattern for auto-including class methods
def self.included( klass )
  klass.extend( ClassMethods )
end
module ClassMethods; end



## base class for enum
class Enum
  ## return a new Enum read-only class

  def initialize( key, value )
    @key   = key
    @value = value
    self.freeze   ## make "immutable"
    self
  end

  ## add read-only attribute readers
  ##  just use attr_reader!!! - why? why not?
  def key()   @key;   end
  def value() @value; end

  def self.value( index )
    ## todo/fix: check for out-of-bound / unknown enum
    ## puts "#{name}.value(#{index})"
    ## pp keys
    ## pp values
    members[ index ]
  end

  def self.zero
    members[0]
  end

  def self.key( key )
    @hash ||= Hash[ keys.zip( members ) ].freeze
    @hash[key]
  end

  def self.[]( key )   ## convenience alias for key
    self.key( key )
  end

  def self.values
    @values ||= (0...keys.size).to_a.freeze
    @values
  end

  def self.size() keys.size; end
  def self.length() size; end   ## alias (as is the ruby tradition)


  def self.convert( arg )
    ## todo/check: support keys too - why? why not?
    ## e.g. Color(0), Color(1)
    ##      Color(:red), Color(:blue) - why? why not?
    value( arg )
  end



  ###################
  ##  meta-programming "macro" - build class (on the fly)
  def self.build_class( class_name, *keys )

    ## todo/fix:
    ##  check class name MUST start with uppercase letter

    ## check if all keys are symbols and follow the ruby id(entifier) naming rules
    keys.each do |key|
      if key.is_a?( Symbol ) && key =~ /\A[a-z][a-zA-Z0-9_]*\z/
      else
        raise ArgumentError.new( "[Enum] arguments to Enum.new must be all symbols following the ruby id naming rules; >#{key}< failed" )
      end
    end

    klass = Class.new( Enum )

    ## add self.new too - note: call/forward to "old" orginal self.new of Event (base) class
    klass.define_singleton_method( :new ) do |*args|
      old_new( *args )
    end

    keys.each_with_index do |key,index|
      klass.class_eval( <<RUBY )
        #{key.upcase} = new( :#{key}, #{index} )

        def #{key}?
          self == #{key.upcase}
        end

        def self.#{key}
          #{key.upcase}
        end
RUBY
    end

    klass.class_eval( <<RUBY )
      def self.keys
        @keys   ||= #{keys}.freeze
      end

      def self.members
        @members ||= [#{keys.map {|key|key.upcase}.join(',')}].freeze
      end
RUBY

    ## note: use Object for "namespacing"
    ##   make all enums convenience converters (always) global
    ##     including uppercase methods (e.g. State(), Color(), etc.) does NOT work otherwise (with other module includes)

    ## add global convenience converter function
    ##  e.g. State(0) is same as State.convert(0)
    ##       Color(0) is same as Color.convert(0)
    Object.class_eval( <<RUBY )
      def #{class_name}( arg )
         #{class_name}.convert( arg )
      end
RUBY

    ## note: use Safe (module) and NO Object for namespacing
    ##   use include Safe to make all enums constants and machinery global
    Safe.const_set( class_name, klass )   ## returns klass (plus sets global constant class name)
  end

  class << self
    alias_method :old_new, :new       # note: store "old" orginal version of new
    alias_method :new,     :build_class    # replace original version with create
  end
end  # class Enum


module ClassMethods
  def enum( class_name, *args )
    ########################################
    # note: lets you use:
    #   enum 'Color', :red, :green, :blue
    #    -or-
    #   enum 'Color', [:red, :green, :blue]
    if args[0].is_a?( Array )
      keys = args[0]
    else
      keys = args
    end

    Enum.new( class_name, *keys )
  end
end # module ClassMethods
end # module Safe


puts Enums.banner   # say hello
