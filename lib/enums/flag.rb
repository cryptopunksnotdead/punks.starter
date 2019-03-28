# encoding: utf-8

###############################
## base class for flag/flags



module Safe
class Flag
  attr_reader :key
  attr_reader :value

  def initialize( *args )
    fmt = "%08b"

    if args.size == 0
      @value = 0   ## same as new(0)
      @key   = :"#{fmt % @value}"   ## use :none for 0 key - why? why not?
    elsif args.size == 1 && args[0].is_a?(Integer)
      @value = args[0]
      @key   = :"#{fmt % @value}"   ## todo: lookup if value is a known flag (with key) - why? why not?
    elsif args.size == 2 && args[0].is_a?(Symbol) && args[1].is_a?(Integer)
      @key   = args[0]
      @value = args[1]
    else
      ## assume flag object or symbols
      @value = 0
      args.each do |arg|
        flag = _typecast_flag!( arg )
        @value |= flag.value
      end
      @key = :"#{fmt % @value}"    ## todo: lookup if value is a known flag (with key) - why? why not?
    end
    self.freeze  ## make "immutable" - should be a value object like an integer number!!!
    self # return self for chaining
  end


  def _typecheck_flag!( o )
    if self.class == o.class
      o
    else
      raise TypeError.new( "[Flag] flag >#{self.class.name}< type expected; got >#{o.class.inspect}<" )
    end
  end

  def _typecast_flag!( o )
    if o.is_a? Symbol   ## auto-convert symbol to flag
      o = self.class.key( o )  ## lookup symbol in "parent" flags class
    end
    _typecheck_flag!( o )
  end


  def ==( other )
    if self.class == other.class
      @value == other.value
    elsif other.is_a?( Integer )  ## note: also allow compare by "plain" integer
      @value == other
    else
      false
    end
  end
  alias_method :eql?, :==


  def member?( other ) _member?(_typecast_flag!( other )); end
  def _member?( other ) @value & other.value == other.value; end


  def bitwise_or( other )
    self.class.new( @value | _typecheck_flag!( other ).value )
  end
  alias_method :|,    :bitwise_or

  def bitwise_and( other )
    self.class.new( @value & _typecheck_flag!( other ).value )
  end
  alias_method :&, :bitwise_and

  def bitwise_xor( other )
    self.class.new( @value ^ _typecheck_flag!( other ).value )
  end
  alias_method :^,      :bitwise_xor

  def bitwise_inverse
     self.class.new( ~@value )
  end
  alias_method :~, :bitwise_inverse


  def set( other )  ## note: typecast also allows symbol e.g (:read_only, etc.)
    self.class.new( @value | _typecast_flag!( other ).value )
  end
  alias_method :flag, :set

  def unset( other )
    self.class.new( @value & ~_typecast_flag!( other ).value )
  end
  alias_method :unflag, :unset

  def toggle( other )
    self.class.new( @value ^ _typecast_flag!( other ).value )
  end




  def self.keys()
    # note: does NOT include none - why? why not?
    @keys ||= members.map { |member| member.key }.freeze
  end

  def self.key( key )
    @hash ||= Hash[ keys.zip( members ) ].freeze
    @hash[key]
  end

  def self.[]( key )  ## convenience alias for key
    self.key( key )
  end


  def self.values()
    # note: does NOT include none - why? why not?
    @values ||= members.map { |member| member.value }.freeze
  end


  def self.zero() @zero ||= new(0); end
  def zero?() @value == 0; end


  def self.convert( *args )
    new( *args )
  end


  ## add size|length too why? why not?
  ## add value() lookup?
  ##   not for now - why? combined values are undefined!! what to return??

  ## add to_i, to_int - why? why not?
  ## def to_i()   @value; end
  ## def to_int() @value; end
end  # class Flag
end # module Safe
