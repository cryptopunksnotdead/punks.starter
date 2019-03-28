# encoding: utf-8

require_relative 'flag'




class FileAttrib < Flag

  ## start with power (base) 0
  ## e.g. 2^0 or 1<<0 = 1 = 0001
  #       2^1 or 1<<1 = 2 = 0010
  #       2^2 or 1<<2 = 4 = 00010
  ## NONE     new( :none, 0 )  ## (always auto-added) built-in default
  READ_ONLY = new( :read_only, 1<<0 )
  HIDDEN    = new( :hidden,    1<<1 )
  SYSTEM    = new( :system,    1<<2 )
  ARCHIVE   = new( :archive,   1<<3 )
  ## (always auto-add) built-in default ALL for all flags or-ed together - why? why not?

  ## def self.none()     NONE;     end
  def self.read_only() READ_ONLY; end
  def self.hidden()    HIDDEN;   end
  def self.system()    SYSTEM;   end
  def self.archive()   ARCHIVE;  end

  def self.members()
    # note: does NOT include none - why? why not?
    ## use flags - why? why not?
    @members ||= [READ_ONLY, HIDDEN, SYSTEM, ARCHIVE].freeze
  end

  def read_only?() _member?( READ_ONLY ); end
  def hidden?()    _member?( HIDDEN ); end
  def system?()    _member?( SYSTEM ); end
  def archive?()   _member?( ARCHIVE ); end
end  # class FileAttrib


module Kernel
  def FileAttrib( *args ) FileAttrib.convert( *args ); end
end # module Kernel


pp FileAttrib.read_only
pp FileAttrib.hidden
pp FileAttrib.system
pp FileAttrib.archive

pp FileAttrib::READ_ONLY
pp FileAttrib::HIDDEN
pp FileAttrib::SYSTEM
pp FileAttrib::ARCHIVE

pp FileAttrib[:read_only]
pp FileAttrib[:hidden]
pp FileAttrib[:system]
pp FileAttrib[:archive]


pp FileAttrib.read_only.value
pp FileAttrib.read_only.key
pp FileAttrib.read_only.is_a? Flag
pp FileAttrib.read_only.is_a? FileAttrib



pp FileAttrib.new
pp FileAttrib.new(0)
pp FileAttrib.new( 1<<1 | 1<<3 )
pp FileAttrib.new( FileAttrib.read_only, FileAttrib.hidden )
pp FileAttrib.new( FileAttrib.read_only | FileAttrib.hidden )
pp FileAttrib.new( FileAttrib.read_only | FileAttrib.hidden | FileAttrib.archive )
pp FileAttrib.new( FileAttrib::READ_ONLY | FileAttrib::HIDDEN )
pp FileAttrib.new( FileAttrib::READ_ONLY, FileAttrib::HIDDEN )
pp FileAttrib.new( :read_only, :hidden )

pp FileAttrib.zero
pp FileAttrib(0)
pp FileAttrib( :read_only )
pp FileAttrib( :read_only, :hidden )

pp FileAttrib( FileAttrib.read_only, FileAttrib.hidden )
pp FileAttrib( FileAttrib.read_only | FileAttrib.hidden )
pp FileAttrib( FileAttrib.read_only | FileAttrib.hidden | FileAttrib.archive )
pp FileAttrib( FileAttrib::READ_ONLY | FileAttrib::HIDDEN )
pp FileAttrib( FileAttrib::READ_ONLY, FileAttrib::HIDDEN )



pp attrib = FileAttrib.new
pp attrib.is_a? Flag
pp attrib.is_a? FileAttrib


puts "set (|=):"
pp attrib.set( FileAttrib.read_only )   # note: set returns a new object
pp attrib.set( FileAttrib::READ_ONLY )
pp attrib.set( :read_only )
pp attrib |  FileAttrib.read_only       # same as FileAttrib#set
pp attrib |= FileAttrib.read_only
pp attrib |= FileAttrib::READ_ONLY
pp attrib |= FileAttrib[:read_only]

pp attrib.set( FileAttrib.hidden )
pp attrib.set( FileAttrib::HIDDEN )
pp attrib.set( :hidden )
pp attrib |  FileAttrib.hidden
pp attrib |= FileAttrib.hidden
pp attrib |= FileAttrib::HIDDEN


puts "toggle (^=):"
pp attrib
pp attrib.toggle( FileAttrib.system )  # note: toggle returns a new object
pp attrib.toggle( FileAttrib::SYSTEM )
pp attrib.toggle( :system )
pp attrib ^  FileAttrib.system        # same as FileAttrib#toggle
pp attrib ^= FileAttrib.system
pp attrib ^= FileAttrib.system
pp attrib ^= FileAttrib.system
pp attrib ^= FileAttrib::SYSTEM

puts "unset (&=~):"
pp attrib.unset( FileAttrib.system )   # note: unset returns a new object
pp attrib.unset( FileAttrib::SYSTEM )
pp attrib.unset( :system )
pp attrib &= ~FileAttrib.system
pp attrib &= ~FileAttrib::SYSTEM


pp attrib.read_only?
pp attrib.hidden?
pp attrib.system?

pp attrib.value


pp FileAttrib.members
pp FileAttrib.keys
pp FileAttrib.values

attrib = FileAttrib( FileAttrib.read_only | FileAttrib.hidden )
pp attrib
pp attrib.read_only?
pp attrib & FileAttrib.read_only
pp attrib & FileAttrib.read_only == FileAttrib.read_only
pp attrib & FileAttrib.read_only != 0
puts "attrib.hidden?"
pp attrib.hidden?
pp attrib.system?


pp attrib == FileAttrib.read_only
pp FileAttrib.read_only == FileAttrib.read_only
pp FileAttrib.read_only == FileAttrib::READ_ONLY
pp FileAttrib.read_only == FileAttrib.hidden
pp FileAttrib.zero == 0
