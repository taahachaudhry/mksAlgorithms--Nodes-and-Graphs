class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_node(val)
    @nodes[val] = Node.new(val)
  end

  def add_edge(val1, val2, cost)
    node1 = @nodes[val1]
    node2 = @nodes[val2]
    node1.children[node2] = cost
    node2.children[node1] = cost
  end

  def path_exists?(val1, val2)
    node1 = @nodes[val1]
    node2 = @nodes[val2]
    reachable = find_reachable_nodes(node1)
    return reachable.include?(node2)
  end

  def find_reachable_nodes(node, reachable_nodes=[])
    reachable_nodes << node
    node.children.each do |child, cost|
      if !reachable_nodes.include?(child)
        find_reachable_nodes(child, reachable_nodes)
      end
    end
    return reachable_nodes
  end

  def print_graph
    puts "Here is your graph:"
    puts "-----"
    @nodes.each do |val, node|
      puts ">>#{val}<< is connected to:"
      node.children.each do |node, cost|
        puts "\t#{node.value}"
      end
    end
    nil
  end
end

class Node
  attr_accessor :value, :children

  def initialize(val, children = {})
    @value = val
    @children = children
  end
end
