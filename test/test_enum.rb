# encoding: utf-8

##
#  to run use
#     ruby -I ./lib -I ./test test/test_enum.rb


require 'helper'


class TestEnum < MiniTest::Test

   include Safe   ## make all enums (and "convenience" converters) global


def test_state
pp Enum.new( 'State', :fundraising, :expired_refund, :successful )


puts "Safe.constants:"
pp Safe.constants
puts "Enum.constants:"
pp Enum.constants
puts "State.constants:"
pp State.constants


pp State.values
pp State.keys
## pp State(0)

pp State.members
pp State.members[0].key
pp State.members[0].value
pp State.members[1].key
pp State.members[1].value

pp State.fundraising.value
pp State.fundraising.key
pp State::FUNDRAISING.value
pp State::FUNDRAISING.key


pp State
state = State.fundraising
pp state.fundraising?
pp state
pp state.value


pp State(0)
pp State(1)
pp State(2)
pp State(3)

pp State.zero
pp State(0) == State.zero
pp State(1) == State.zero

pp State.value(0)
pp State.key(:fundraising)
pp State[:fundraising]
end

def test_color
pp Enum.new( 'Color', :red, :green, :blue )
pp Color.zero
pp Color(0)
pp Color.red
pp Color.values
pp Color.keys
pp Color.constants
pp Color.members
pp Color(1)
pp Color.value(1)
pp Color.key(:red)
pp Color[:red]
color = Color.red
pp color.red?
pp color == Color.red
pp color.blue?
pp color == Color.blue

pp Color::RED
pp Color.members
end

end # class TestEnum
