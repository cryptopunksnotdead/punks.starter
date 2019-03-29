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
    self.freeze
    self
  end

  def self._typecheck_flag!( o )
    if self == o.class
      o
    else
      raise TypeError.new( "[Flag] flag >#{name}< type expected; got >#{o.class.inspect}<" )
    end
  end

  def self._typecast_flag!( o )
    if o.is_a? Symbol   ## auto-convert symbol to flag
      o = key( o )  ## lookup symbol in "parent" flags class
    end
    _typecheck_flag!( o )
  end

  def _typecheck_flag!( o ) self.class._typecheck_flag!( o ); end
  def _typecast_flag!( o ) self.class._typecast_flag!( o ); end



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


  def member?( other )
    other = _typecast_flag!( other )
    @value & other.value == other.value
  end


  def bitwise_or( other )
    self.class.build( @value | _typecheck_flag!( other ).value )
  end
  alias_method :|, :bitwise_or

  def bitwise_and( other )
    self.class.build( @value & _typecheck_flag!( other ).value )
  end
  alias_method :&, :bitwise_and

  def bitwise_xor( other )
    self.class.build( @value ^ _typecheck_flag!( other ).value )
  end
  alias_method :^, :bitwise_xor

  def bitwise_inverse
     self.class.build( ~@value )
  end
  alias_method :~, :bitwise_inverse


  def set( other )  ## note: typecast also allows symbol e.g (:read_only, etc.)
    self.class.build( @value | _typecast_flag!( other ).value )
  end
  alias_method :flag, :set

  def unset( other )
    self.class.build( @value & ~_typecast_flag!( other ).value )
  end
  alias_method :unflag, :unset

  def toggle( other )
    self.class.build( @value ^ _typecast_flag!( other ).value )
  end



  def self.keys()
    # note: does NOT include :none (and :all)
    @keys ||= members.map { |member| member.key }.freeze
  end

  def self.key( key )
    # note: does NOT include :none (and :all)
    @hash_by_key ||= Hash[ keys.zip( members ) ].freeze
    @hash_by_key[key]
  end

  def self.[]( key )  ## convenience alias for key
    self.key( key )
  end


  def self.values()
    # note: does NOT include :none (and :all)
    @values ||= members.map { |member| member.value }.freeze
  end

  def self.value( value )
    ## note: adds :none and :all for value lookup
    @hash_by_value ||= Hash[ values.zip( members ) ].merge( self::NONE.value => self::NONE,
                                                            self::ALL.value  => self::ALL ).freeze
    @hash_by_value[value]
  end

  def self.build( value )
    o = self.value( value )   # lookup if value is a known flag (with key)
    o = new( :"#{'%08b' % value}", value )  if o.nil?
    o
  end


  def self.zero() @zero ||= self::NONE; end
  def zero?() @value == 0; end

  def self.none() self::NONE; end
  def none?() @value == 0; end
  def self.all() self::ALL; end
  def all?() @value & self.class::ALL.value == self.class::ALL.value; end


  def self.convert( *args )
    if args.size == 0
      self::NONE
    elsif args.size == 1 && args[0].is_a?(Integer)
      build( args[0] )
    else
      ## assume flag object or symbols
      value = 0
      args.each do |arg|
        flag = _typecast_flag!( arg )
        value |= flag.value
      end
      build( value )
    end
  end

  ## add size|length too why? why not?

  ## add to_i, to_int - why? why not?
  ## def to_i()   @value; end
  ## def to_int() @value; end
end  # class Flag
end # module Safe
