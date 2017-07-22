require_relative './node.rb'

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add_edge(node_a, node_b)
    node_a.edges.add(node_b.number)
    node_b.edges.add(node_a.number)
  end
end
