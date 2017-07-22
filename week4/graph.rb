require_relative './node.rb'

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_edge(node_a, node_b)
    node_a.edges << node_b.number
  end
end
