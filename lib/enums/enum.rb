# encoding: utf-8

###############################
## base class for enum

module Safe
class Enum
  ## return a new Enum read-only class
  attr_reader :key
  attr_reader :value

  def initialize( key, value )
    @key   = key
    @value = value
    self.freeze   ## make "immutable"
    self
  end


  def self.keys
    @keys ||= members.map {|member| member.key}.freeze
    @keys
  end

  def self.key( key )
    ## note: returns nil now for unknown keys
    ##   use/raise IndexError or something - why? why not?
    @hash_by_key ||= Hash[ keys.zip( members ) ].freeze
    @hash_by_key[key]
  end

  def self.[]( key )   ## convenience alias for key
    self.key( key )
  end


  def self.values
    @values ||= members.map {|member| member.value}.freeze
    @values
  end

  def self.value( value )
    ## note: returns nil now for unknown values
    ##   use/raise IndexError or something - why? why not?
    @hash_by_value ||= Hash[ values.zip( members ) ].freeze
    @hash_by_value[value]
  end


  def self.size() keys.size; end
  def self.length() size; end   ## alias (as is the ruby tradition)


  def self.convert( arg )
    ## todo/check: support keys too - why? why not?
    ## e.g. Color(0), Color(1)
    ##      Color(:red), Color(:blue) - why? why not?
    ## note: will ALWAYS look-up by (member) index and NOT by value (integer number value might be different!!)
    members[ arg ]
  end

  def self.zero() members[0]; end
  def zero?() self == self.class.zero; end
end  # class Enum
end  # module Safe
