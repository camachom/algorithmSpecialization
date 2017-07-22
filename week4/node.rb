require 'set'

class Node
  attr_reader :number
  attr_accessor :edges

  def initialize(number)
    @edges = []
    @number = number
  end
end
