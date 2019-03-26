require 'pp'



class Flag

  class FlagSet
     attr_reader :value
     def initialize( value )
       @value = value
       self.freeze   ## make "immutable"
       self
     end
     def flag_class() Flag; end
     def |( other )
       if flag_class == other.class
         self.class.new( @value | other.value )
       else
          raise TypeError.new( "[FlagSet] flagset >#{flag_class.name}< type expected; got >#{other.class.inspect}<" )
       end
     end
  end # nested class FlagSet


  attr_reader :key
  attr_reader :value

  def initialize( key, value )
    @key   = key
    @value = value
    self.freeze   ## make "immutable"
    self
  end


  def self._typecheck( other )
    if self == other.class
      other
    else
      raise TypeError.new( "[Flag] flag >#{name}< type expected; got >#{other.class.inspect}<" )
    end
  end

  def |( other )
    self.class._typecheck( other )
    self.class::FlagSet.new( @value | other.value )
  end
end  # class Flag



class Flags
  def self.newzero() new; end
  def self.zero()    @zero ||= newzero.freeze end

  def zero?() @value == 0; end


  attr_reader :value

  def initialize( *args )
    if args.size == 0
      @value = 0   ## same as new(0)
    elsif args.size == 1 && args[0].is_a?(Integer)
      @value = args[0]
    elsif args.size == 1 && args[0].is_a?(self.class::Flag::FlagSet)
      @value = args[0].value
    else
      ## assume flag object or symbols
      @value = 0
      args.each do |arg|
        flag = _typecast( arg )
        @value |= flag.value
      end
    end
    self # return self for chaining
  end


  def _typecast( o )
    if o.is_a? Symbol   ## auto-convert symbol to flag
      o = self.class.key( o )
    end

    self.class::Flag._typecheck( o )
  end


  def member?( other ) _member?(_typecast( other )); end
  def _member?( other ) @value & other.value  != 0; end

  def set( other )  _set(_typecast( other )); end
  def _set( other )
    @value |= other.value
    self ## return self for chaining
  end
  alias_method :flag, :set

  def unset( other ) _unset(_typecast( other )); end
  def _unset( other )
    @value &= ~other.value
    self ## return self for chaining
  end
  alias_method :unflag, :unset

  def toggle( other ) _toggle(_typecast( other )); end
  def _toggle( other )
    @value ^= other.value
    self ## return self for chaining
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


  ## add values, size|length too why? why not?


  ## add to_i, to_int - why? why not?
  ## def to_i()   @value; end
  ## def to_int() @value; end
end  # class Flags




class FileAttribs < Flags

  class Flag < ::Flag
    class FlagSet < ::Flag::FlagSet  ## add nested "typesafe" flagset class too
      def flag_class() Flag; end
    end
  end
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

  def self.keys()
    # note: does NOT include none - why? why not?
    @keys ||= [:readonly, :hidden, :system, :archive].freeze
  end

  def self.members()
    # note: does NOT include none - why? why not?
    ## use flags - why? why not?
    @members ||= [READONLY, HIDDEN, SYSTEM, ARCHIVE].freeze
  end

  def readonly?() _member?( READONLY ); end
  def hidden?()   _member?( HIDDEN ); end
  def system?()   _member?( SYSTEM ); end
  def archive?()  _member?( ARCHIVE ); end

  def readonly=(value)  value ? _set( READONLY ) : _unset( READONLY ); end
  def hidden=(value)    value ? _set( HIDDEN )   : _unset( HIDDEN );   end
  def system=(value)    value ? _set( SYSTEM )   : _unset( SYSTEM );   end
  def archive=(value)   value ? _set( ARCHIVE )  : _unset( ARCHIVE );  end
end  # class FileAttribs


module Kernel
  def FileAttribs( *args ) FileAttribs.convert( *args ); end
end # module Kernel



pp FileAttribs::READONLY
pp FileAttribs::HIDDEN
pp FileAttribs::SYSTEM
pp FileAttribs::ARCHIVE

pp FileAttribs.readonly
pp FileAttribs.hidden
pp FileAttribs.system
pp FileAttribs.archive


pp FileAttribs.new
pp FileAttribs.new(0)
pp FileAttribs.new( 1<<1 | 1<<3 )
pp FileAttribs.new( FileAttribs::READONLY | FileAttribs::HIDDEN )
pp FileAttribs.new( FileAttribs::READONLY, FileAttribs::HIDDEN )
pp FileAttribs.new( FileAttribs.readonly, FileAttribs.hidden )
pp FileAttribs.new( FileAttribs.readonly | FileAttribs.hidden | FileAttribs.archive )
pp FileAttribs.new( :readonly, :hidden )

pp FileAttribs.newzero
pp FileAttribs.zero

pp FileAttribs(0)
pp FileAttribs( :readonly )
pp FileAttribs( :readonly, :hidden )

pp FileAttribs( FileAttribs::READONLY | FileAttribs::HIDDEN )
pp FileAttribs( FileAttribs::READONLY, FileAttribs::HIDDEN )
pp FileAttribs( FileAttribs.readonly, FileAttribs.hidden )
pp FileAttribs( FileAttribs.readonly | FileAttribs.hidden | FileAttribs.archive )



pp attribs = FileAttribs.new
pp attribs.set( FileAttribs::READONLY )
pp attribs.set( FileAttribs::HIDDEN )
pp attribs.unset( FileAttribs::SYSTEM )
pp attribs.toggle( FileAttribs::SYSTEM )

pp attribs.set( FileAttribs.readonly )
pp attribs.set( FileAttribs.hidden )
pp attribs.unset( FileAttribs.system )
pp attribs.toggle( FileAttribs.system )

pp attribs.set( :readonly )
pp attribs.set( :hidden )
pp attribs.unset( :system )
pp attribs.toggle( :system )

pp attribs.readonly?
pp attribs.hidden?
pp attribs.system?

pp attribs.readonly = true
pp attribs.hidden   = true
pp attribs.system   = true

pp attribs.readonly = false
pp attribs.hidden   = false
pp attribs.system   = false
pp attribs.value


pp FileAttribs.keys
pp FileAttribs.members
