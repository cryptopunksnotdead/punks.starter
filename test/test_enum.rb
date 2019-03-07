# encoding: utf-8

##
#  to run use
#     ruby -I ./lib -I ./test test/test_enum.rb


require 'helper'


class TestEnum < MiniTest::Test

   include Safe   ## make all enums (and "convenience" converters) global


   ## Enum.new( 'State', :fundraising, :expired_refund, :successful )
   enum 'State', :fundraising, :expired_refund, :successful

   pp State
   pp State(0)

   ## Enum.new( 'Color', :red, :green, :blue )
   enum 'Color', :red, :green, :blue

   pp Color
   pp Color(0)

   puts "Safe.constants:"
   pp Safe.constants  #=> [:ClassMethods, :Enum, :State, :Color]
   puts "Enum.constants:"
   pp Enum.constants  #=> []


def test_state
  assert_equal [:FUNDRAISING, :EXPIRED_REFUND, :SUCCESSFUL], State.constants

  assert_equal [0, 1, 2], State.values
  assert_equal [:fundraising, :expired_refund, :successful], State.keys

  assert_equal 3, State.size
  assert_equal 3, State.length

  assert_equal State.fundraising,    State::FUNDRAISING
  assert_equal State.expired_refund, State::EXPIRED_REFUND
  assert_equal State.successful,     State::SUCCESSFUL

  pp State.members
  assert_equal :fundraising,    State.members[0].key
  assert_equal 0,               State.members[0].value
  assert_equal :expired_refund, State.members[1].key
  assert_equal 1,               State.members[1].value

  assert_equal 0,               State.fundraising.value
  assert_equal :fundraising,    State.fundraising.key
  assert_equal 0,               State::FUNDRAISING.value
  assert_equal :fundraising,    State::FUNDRAISING.key

  pp State
  state = State.fundraising
  pp state
  assert_equal true, state.fundraising?
  assert_equal 0,    state.value
  assert_equal true, state.is_a?( Enum  )
  assert_equal true, state.is_a?( State )

  assert_equal State.fundraising,    State(0)
  assert_equal State.expired_refund, State(1)
  assert_equal State.successful,     State(2)

  pp State.zero
  assert_equal true,  State(0) == State.zero
  assert_equal false, State(1) == State.zero

  assert_equal State.fundraising, State.value(0)
  assert_equal State.fundraising, State.key(:fundraising)
  assert_equal State.fundraising, State[:fundraising]
end


def test_color
  assert_equal [0, 1, 2],             Color.values
  assert_equal [:red, :green, :blue], Color.keys
  assert_equal [:RED, :GREEN, :BLUE], Color.constants

  assert_equal 3, Color.size
  assert_equal 3, Color.length

  pp Color.zero
  pp Color.red

  assert_equal Color.red,   Color(0)
  assert_equal Color.green, Color(1)
  assert_equal Color.blue,  Color(2)

  pp Color.members
  assert_equal Color.green, Color.value(1)
  assert_equal Color.red,   Color.key(:red)
  assert_equal Color.red,   Color[:red]

  color = Color.red
  assert_equal true,  color.red?
  assert_equal true,  color == Color.red
  assert_equal false, color.blue?
  assert_equal false, color == Color.blue

  assert_equal Color.red,   Color::RED
  assert_equal Color.green, Color::GREEN
  assert_equal Color.blue,  Color::BLUE
end

end # class TestEnum
