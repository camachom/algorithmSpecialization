require 'byebug'
require_relative './graph.rb'

graph = Graph.new

File.foreach('./testfile.txt') do |line|
  int_array = line.split("\t")[0...-1].map!(&:to_i)
  current_number = int_array.first
  edges = int_array[1..-1]

  current_node = graph.nodes[current_number]
  # if the current node was not found
  if !current_node
    new_node = Node.new(current_number)
    graph.nodes[new_node.number] = new_node
    current_node = new_node
  end

  # start adding edges to the current node
  edges.each do |edge|
    edge_node = graph.nodes[edge]

    if !edge_node
      new_node = Node.new(edge)
      graph.nodes[new_node.number] = new_node
      edge_node = new_node
    end

    graph.add_edge(current_node, edge_node)
  end
end

def minimum_cut(graph)
  graph_copy = Marshal::load(Marshal.dump(graph))
  until graph_copy.nodes.length == 2
    # picks a random node_a from list of graph nodes
    random_key_a = graph_copy.nodes.keys.sample
    node_a = graph_copy.nodes[random_key_a]

    # pick a random node_b that shares and edge with node_a
    random_key_b = node_a.edges.sample
    node_b = graph_copy.nodes[random_key_b]

    # merge both sets
    node_a.edges = node_a.edges.concat(node_b.edges)

    # remove referrences to collapsed node
    node_b.edges.each do |num|
      edge_node = graph_copy.nodes[num]

      edge_node.edges.map! do |int|
        int == node_b.number ? node_a.number : int
      end
    end

    # remove self loops
    node_a.edges.delete(node_a.number)

    # remove node_b frmom graph
    graph_copy.nodes.delete(node_b.number)
  end

  p "#{graph_copy.nodes.shift[1].edges.length}"
end
