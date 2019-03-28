# encoding: utf-8

##
#  to run use
#     ruby -I ./lib -I ./test test/test_flag.rb


require 'helper'


module Safe
  ## Flags.new( :FileAttrib, :read_only, :hidden, :system, :archive )
  enum :FileAttrib, [:read_only, :hidden, :system, :archive], flags: true


  pp FileAttrib
  pp FileAttrib(0)

  puts "Safe.constants:"
  pp Safe.constants  #=> [:SafeHelper, :Enum, :State, :Color]
  puts "Flag.constants:"
  pp Flag.constants  #=> []
  puts "FileAttrib.constants:"
  pp FileAttrib.constants  #=> []
end


class TestFlag < MiniTest::Test

   include Safe   ## make all enums (and "convenience" converters) global


def test_attrib

  assert_equal [1<<0, 1<<1, 1<<2, 1<<3], FileAttrib.values
  assert_equal [:read_only, :hidden, :system, :archive], FileAttrib.keys

  assert_equal FileAttrib.read_only, FileAttrib::READ_ONLY
  assert_equal FileAttrib.hidden,    FileAttrib::HIDDEN
  assert_equal FileAttrib.system,    FileAttrib::SYSTEM
  assert_equal FileAttrib.archive,   FileAttrib::ARCHIVE

  assert_equal FileAttrib.read_only, FileAttrib[:read_only]
  assert_equal FileAttrib.hidden,    FileAttrib[:hidden]
  assert_equal FileAttrib.system,    FileAttrib[:system]
  assert_equal FileAttrib.archive,   FileAttrib[:archive]

  assert_equal 1<<0,      FileAttrib.read_only.value
  assert_equal :read_only, FileAttrib.read_only.key
  assert_equal true,      FileAttrib.read_only.is_a?( Flag )
  assert_equal true,      FileAttrib.read_only.is_a?( FileAttrib )

  pp FileAttrib.members
  assert_equal :read_only, FileAttrib.members[0].key
  assert_equal 1<<0,       FileAttrib.members[0].value
  assert_equal :hidden,    FileAttrib.members[1].key
  assert_equal 1<<1,       FileAttrib.members[1].value

  assert_equal 1<<0,       FileAttrib.read_only.value
  assert_equal :read_only, FileAttrib.read_only.key
  assert_equal 1<<0,       FileAttrib::READ_ONLY.value
  assert_equal :read_only, FileAttrib::READ_ONLY.key
end

def test_text_style
   Flag.new( :TextStyle, :bold, :italic, :underline )

   assert_equal [1<<0, 1<<1, 1<<2], TextStyle.values
   assert_equal [:bold, :italic, :underline], TextStyle.keys

   style = TextStyle(0)
   assert_equal true, style == 0
   style |= TextStyle.bold
   assert_equal true, style.member?( :bold )
   assert_equal true, style.member?( TextStyle.bold )
   assert_equal true, style & TextStyle.bold == TextStyle.bold
   assert_equal true, style & TextStyle.bold != 0

   assert_equal false, style.member?( :italic )
   assert_equal false, style.member?( TextStyle.italic )
   style |= TextStyle.italic
   assert_equal true, style.member?( :italic )
   assert_equal true, style.member?( TextStyle.italic )
   assert_equal true, style & TextStyle.italic == TextStyle.italic
   assert_equal true, style & TextStyle.italic != 0
end


end # class TestFlag
