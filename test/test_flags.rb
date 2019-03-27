# encoding: utf-8

##
#  to run use
#     ruby -I ./lib -I ./test test/test_flags.rb


require 'helper'


module Safe
  ## Flags.new( :FileAttribs, :readonly, :hidden, :system, :archive )
  enum :FileAttribs, [:readonly, :hidden, :system, :archive], flags: true


  pp FileAttribs
  pp FileAttribs::Flag
  pp FileAttribs(0)

  puts "Safe.constants:"
  pp Safe.constants  #=> [:SafeHelper, :Enum, :State, :Color]
  puts "Flags.constants:"
  pp Flags.constants  #=> []
  puts "Flag.constants:"
  pp Flag.constants  #=> []
  puts "FileAttribs.constants:"
  pp FileAttribs.constants  #=> []
end


class TestFlags < MiniTest::Test

   include Safe   ## make all enums (and "convenience" converters) global


def test_attribs

  assert_equal [1<<0, 1<<1, 1<<2, 1<<3], FileAttribs.values
  assert_equal [:readonly, :hidden, :system, :archive], FileAttribs.keys

  assert_equal FileAttribs.readonly, FileAttribs::READONLY
  assert_equal FileAttribs.hidden,   FileAttribs::HIDDEN
  assert_equal FileAttribs.system,   FileAttribs::SYSTEM
  assert_equal FileAttribs.archive,  FileAttribs::ARCHIVE

  assert_equal FileAttribs.readonly, FileAttribs[:readonly]
  assert_equal FileAttribs.hidden,   FileAttribs[:hidden]
  assert_equal FileAttribs.system,   FileAttribs[:system]
  assert_equal FileAttribs.archive,  FileAttribs[:archive]

  assert_equal 1<<0,      FileAttribs.readonly.value
  assert_equal :readonly, FileAttribs.readonly.key
  assert_equal true,      FileAttribs.readonly.is_a?( Flag )
  assert_equal true,      FileAttribs.readonly.is_a?( FileAttribs::Flag )

  pp FileAttribs.members
  assert_equal :readonly, FileAttribs.members[0].key
  assert_equal 1<<0,      FileAttribs.members[0].value
  assert_equal :hidden,   FileAttribs.members[1].key
  assert_equal 1<<1,      FileAttribs.members[1].value

  assert_equal 1<<0,      FileAttribs.readonly.value
  assert_equal :readonly, FileAttribs.readonly.key
  assert_equal 1<<0,      FileAttribs::READONLY.value
  assert_equal :readonly, FileAttribs::READONLY.key
end

end # class TestFlags
