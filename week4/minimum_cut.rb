require 'byebug'
require_relative './graph.rb'

graph = Graph.new

File.foreach('./testfile.txt') do |line|
  int_array = line.split("\t")[0...-1].map!(&:to_i)
  current_number = int_array.first

  current_node = graph.nodes.find do |node|
    node.number == current_number
  end

  # if the current node was not found
  if !current_node
    new_node = Node.new(current_number)
    graph.nodes << new_node
    current_node = new_node
  end

  # start adding edges to the current node
  current_edges = int_array[1..-1]
  graph_node_hash = {}
  graph.nodes.each do |node|
    graph_node_hash[node.number] = node
  end

  current_edges.each do |edge|
    edge_node = graph_node_hash[edge]

    if !edge_node
      new_node = Node.new(edge)
      graph.nodes << new_node
      graph_node_hash[edge] = new_node
      edge_node = new_node
    end

    graph.add_edge(current_node, edge_node)
  end
end

def minimum_cut(graph)
  graph_copy = Marshal::load(Marshal.dump(graph))
  until graph_copy.nodes.length == 2
    # picks a random node_a from list of graph nodes
    random_idx = rand(graph_copy.nodes.length)
    node_a = graph_copy.nodes[random_idx]

    # pick a random node_b that shares and edge with node_a
    random_idx_2 = rand(node_a.edges.length)
    node_b = graph_copy.nodes.find do |node|
      node.number == node_a.edges.to_a[random_idx_2]
    end

    # remove referrences to collapsed node
    node_b.edges.each do |num|
      edge_node = graph_copy.nodes.find do |node|
        node.number == num
      end

      edge_node.edges.delete_if do |int|
        int == node_b.number
      end
    end

    # merge both sets
    node_b.edges.each do |edge|
      edge_node = graph_copy.nodes.find do |node|
        node.number == edge
      end

      graph_copy.add_edge(node_a, edge_node)
    end

    # remove self loops and node_b pointer
    node_a.edges.delete_if do |number|
      number == node_a.number || number == node_b.number
    end

    # remove node_a frmom graph
    graph_copy.nodes = graph_copy.nodes.delete_if do |node|
      node.number == node_b.number
    end
  end
  byebug
end

minimum_cut(graph)
p 'here'
