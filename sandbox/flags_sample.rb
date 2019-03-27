# encoding: utf-8

require_relative 'flags'




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
