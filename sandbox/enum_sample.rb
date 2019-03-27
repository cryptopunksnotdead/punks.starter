require 'pp'

## Example:
##   Enum.new( :State, :fundraising, :expired_refund, :successful)
##     auto-creates/builds:

class Enum
  def initialize( key, value )
      @key   = key
      @value = value
  end
end

class State < Enum

  FUNDRAISING    = new(:fundraising,    0)
  EXPIRED_REFUND = new(:expired_refund, 1)
  SUCCESSFUL     = new(:successful,     2)

  def self.fundraising()    FUNDRAISING; end
  def self.expired_refund() EXPIRED_REFUND; end
  def self.successful()     SUCCESSFUL; end

  def fundraising?()     self == FUNDRAISING; end
  def expired_refund?()  self == EXPIRED_REFUND; end
  def successful?()      self == SUCCESSFUL; end
end

pp state = State.fundraising     #=> #<State @key=:fundraising, @value=0>
pp state.fundraising?            #=> true
pp state.expired_refund?         #=> false
pp state.successful?             #=> false

pp state = State.expired_refund  #=> #<State @key=:expired_refund, @value=1>
pp state.fundraising?            #=> false
pp state.expired_refund?         #=> true
pp state.successful?             #=> false
