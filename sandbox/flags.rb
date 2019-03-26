require 'pp'



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
  def self.zero() @zero ||= new(0); end

  def zero?() @value == 0; end


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

  def self.values()
    # note: does NOT include none - why? why not?
    @values ||= members.map { |member| member.value }.freeze
  end


  def self.key( key )
    @hash ||= Hash[ keys.zip( members ) ].freeze
    @hash[key]
  end

  def self.[]( key )  ## convenience alias for key
    self.key( key )
  end


  def self.convert( *args )
    new( *args )
  end


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




class FileAttribs < Flags

  class Flag < ::Flag; end  # nested flag class for "typesafe" flags

  ## start with power (base) 0
  ## e.g. 2^0 or 1<<0 = 1 = 0001
  #       2^1 or 1<<1 = 2 = 0010
  #       2^2 or 1<<2 = 4 = 00010
  ## NONE     = Flag.new( :none, 0 )  ## (always auto-added) built-in default
  READONLY = Flag.new( :readonly, 1<<0 )
  HIDDEN   = Flag.new( :hidden,   1<<1 )
  SYSTEM   = Flag.new( :system,   1<<2 )
  ARCHIVE  = Flag.new( :archive,  1<<3 )
  ## (always auto-add) built-in default ALL for all flags or-ed together - why? why not?

  ## def self.none()     NONE;     end
  def self.readonly() READONLY; end
  def self.hidden()   HIDDEN;   end
  def self.system()   SYSTEM;   end
  def self.archive()  ARCHIVE;  end

  def self.members()
    # note: does NOT include none - why? why not?
    ## use flags - why? why not?
    @members ||= [READONLY, HIDDEN, SYSTEM, ARCHIVE].freeze
  end

  def readonly?() _member?( READONLY ); end
  def hidden?()   _member?( HIDDEN ); end
  def system?()   _member?( SYSTEM ); end
  def archive?()  _member?( ARCHIVE ); end
end  # class FileAttribs


module Kernel
  def FileAttribs( *args ) FileAttribs.convert( *args ); end
end # module Kernel


pp FileAttribs.readonly
pp FileAttribs.hidden
pp FileAttribs.system
pp FileAttribs.archive

pp FileAttribs::READONLY
pp FileAttribs::HIDDEN
pp FileAttribs::SYSTEM
pp FileAttribs::ARCHIVE

pp FileAttribs[:readonly]
pp FileAttribs[:hidden]
pp FileAttribs[:system]
pp FileAttribs[:archive]


pp FileAttribs.readonly.value
pp FileAttribs.readonly.key
pp FileAttribs.readonly.is_a? Flag
pp FileAttribs.readonly.is_a? FileAttribs::Flag



pp FileAttribs.new
pp FileAttribs.new(0)
pp FileAttribs.new( 1<<1 | 1<<3 )
pp FileAttribs.new( FileAttribs.readonly, FileAttribs.hidden )
pp FileAttribs.new( FileAttribs.readonly | FileAttribs.hidden )
pp FileAttribs.new( FileAttribs.readonly | FileAttribs.hidden | FileAttribs.archive )
pp FileAttribs.new( FileAttribs::READONLY | FileAttribs::HIDDEN )
pp FileAttribs.new( FileAttribs::READONLY, FileAttribs::HIDDEN )
pp FileAttribs.new( :readonly, :hidden )

pp FileAttribs.zero
pp FileAttribs(0)
pp FileAttribs( :readonly )
pp FileAttribs( :readonly, :hidden )

pp FileAttribs( FileAttribs.readonly, FileAttribs.hidden )
pp FileAttribs( FileAttribs.readonly | FileAttribs.hidden )
pp FileAttribs( FileAttribs.readonly | FileAttribs.hidden | FileAttribs.archive )
pp FileAttribs( FileAttribs::READONLY | FileAttribs::HIDDEN )
pp FileAttribs( FileAttribs::READONLY, FileAttribs::HIDDEN )



pp attribs = FileAttribs.new
pp attribs.is_a? Flags
pp attribs.is_a? FileAttribs


puts "set (|=):"
pp attribs.set( FileAttribs.readonly )   # note: set returns a new object
pp attribs.set( FileAttribs::READONLY )
pp attribs.set( :readonly )
pp attribs |  FileAttribs.readonly       # same as FileAttribs#set
pp attribs |= FileAttribs.readonly
pp attribs |= FileAttribs::READONLY
pp attribs |= FileAttribs[:readonly]

pp attribs.set( FileAttribs.hidden )
pp attribs.set( FileAttribs::HIDDEN )
pp attribs.set( :hidden )
pp attribs |  FileAttribs.hidden
pp attribs |= FileAttribs.hidden
pp attribs |= FileAttribs::HIDDEN


puts "toggle (^=):"
pp attribs
pp attribs.toggle( FileAttribs.system )  # note: toggle returns a new object
pp attribs.toggle( FileAttribs::SYSTEM )
pp attribs.toggle( :system )
pp attribs ^  FileAttribs.system        # same as FileAttribs#toggle
pp attribs ^= FileAttribs.system
pp attribs ^= FileAttribs.system
pp attribs ^= FileAttribs.system
pp attribs ^= FileAttribs::SYSTEM

puts "unset (&=~):"
pp attribs.unset( FileAttribs.system )   # note: unset returns a new object
pp attribs.unset( FileAttribs::SYSTEM )
pp attribs.unset( :system )
pp attribs &= ~FileAttribs.system
pp attribs &= ~FileAttribs::SYSTEM


pp attribs.readonly?
pp attribs.hidden?
pp attribs.system?

pp attribs.value


pp FileAttribs.members
pp FileAttribs.keys
pp FileAttribs.values

attribs = FileAttribs( FileAttribs.readonly | FileAttribs.hidden )
pp attribs
pp attribs.readonly?
pp attribs & FileAttribs.readonly
pp attribs & FileAttribs.readonly == FileAttribs.readonly
pp attribs & FileAttribs.readonly == 0
pp attribs.hidden?
pp attribs.system?


pp attribs == FileAttribs.readonly
pp FileAttribs.readonly == FileAttribs.readonly
pp FileAttribs.readonly == FileAttribs::READONLY
pp FileAttribs.readonly == FileAttribs.hidden
pp FileAttribs.zero == 0
