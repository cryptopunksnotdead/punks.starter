# encoding: utf-8

###############################
## base class for flag/flags



module Safe
class Flag

  attr_reader :key
  attr_reader :value

  def initialize( key, value )
    @key   = key
    @value = value
    self.freeze   ## make "immutable"
    self
  end


  def self._typecheck!( o )
    if self == o.class
      o
    else
      raise TypeError.new( "[Flag] flag >#{name}< type expected; got >#{o.class.inspect}<" )
    end
  end

  def self._value!( o )
    if o.is_a? Integer
      o
    else
      _typecheck!( o )
      o.value
    end
  end

  def bitwise_or( other )   ## bitwise-or
    ## note: returns "plain" integer
    @value | self.class._value!( other )
  end
  alias_method :|, :bitwise_or

  def bitwise_inverse()  ## bitwise-inverse
    ## note: returns "plain" integer
     ~@value
  end
  alias_method :~, :bitwise_inverse


  def coerce( other )
    puts "[Flag] coerce( self= >#{self.inspect}<, other= >#{other.inspect}< #{other.class.name} )"
    if other.is_a?( Integer )
      [other, @value]
    else
      raise TypeError.new( "[Flag] coerce - wrong type >#{other.inspect}< #{other.class.name} - Integer number expected" )
    end
  end
end  # class Flag



class Flags
  attr_reader :value

  def initialize( *args )
    if args.size == 0
      @value = 0   ## same as new(0)
    elsif args.size == 1 && args[0].is_a?(Integer)
      @value = args[0]
    else
      ## assume flag object or symbols
      @value = 0
      args.each do |arg|
        flag = _typecast_flag!( arg )
        @value |= flag.value
      end
    end
    self.freeze  ## make "immutable" - should be a value object like an integer number!!!
    self # return self for chaining
  end


  def _value_for_flag!( o )
    self.class::Flag._value!( o )
  end

  def _typecheck_flag!( o )
    self.class::Flag._typecheck!( o )
  end

  def _typecast_flag!( o )
    if o.is_a? Symbol   ## auto-convert symbol to flag
      o = self.class.key( o )  ## lookup symbol in "parent" flags class
    end
    _typecheck_flag!( o )
  end


  def member?( other ) _member?(_typecast_flag!( other )); end
  def _member?( other ) @value & other.value  != 0; end


  def bitwise_or( other )
    _unsafe_bitwise_or( _value_for_flag!( other ) )
  end
  alias_method :|, :bitwise_or

  def _unsafe_bitwise_or( other )   ## always assumes other is an integer
    self.class.new( @value | other )
  end

  def set( other )  ## typesafe version of bitwise-or (|=) (no "plain" Integer allowed)
    _unsafe_bitwise_or( _typecast_flag!( other ).value )
  end
  alias_method :flag, :set


  def bitwise_and( other )
    _unsafe_bitwise_and( _value_for_flag!( other ) )
  end
  alias_method :&, :bitwise_and

  def _unsafe_bitwise_and( other )
    self.class.new( @value & other )
  end


  def unset( other )  ## typesafe version of bitwise-and/bitwise-inverse (&=~) (no "plain" Integer allowed)
    _unsafe_bitwise_and( ~_typecast_flag!( other ).value )
  end
  alias_method :unflag, :unset


  def bitwise_xor( other )
    _unsafe_bitwise_xor( _value_for_flag!( other ))
  end
  alias_method :^, :bitwise_xor

  def _unsafe_bitwise_xor( other )
    self.class.new( @value ^ other )
  end

  def toggle( other ) ## typesafe version of bitwise-xor (^=) (no "plain" Integer allowed)
    _unsafe_bitwise_xor( _typecast_flag!( other ).value )
  end



  def self.keys()
    # note: does NOT include none - why? why not?
    @keys ||= members.map { |member| member.key }.freeze
  end

  def self.key( key )
    @hash_by_key ||= Hash[ keys.zip( members ) ].freeze
    @hash_by_key[key]
  end

  def self.[]( key )  ## convenience alias for key
    self.key( key )
  end


  def self.values()
    # note: does NOT include none - why? why not?
    @values ||= members.map { |member| member.value }.freeze
  end


  def self.convert( *args )
    new( *args )
  end

  def self.zero() @zero ||= new(0); end
  def zero?() @value == 0; end

  ### todo/fix:
  ##  add ==/eql?
  ##   for self AND flag AND integer
  ##     always compare integer value


  ## add size|length too why? why not?
  ## add value() lookup?
  ##   not for now - why? combined values are undefined!! what to return??

  ## add to_i, to_int - why? why not?
  ## def to_i()   @value; end
  ## def to_int() @value; end
end  # class Flags
end # module Safe
