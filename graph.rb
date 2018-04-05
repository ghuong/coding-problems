require 'set'

# My implementation of a graph as adjacency lists
class MyGraph
  include Enumerable

  attr_accessor :nodes

  def initialize
    @nodes = Set.new
  end

  def add(node)
    return if @nodes.include? node

    @nodes.add(node)
    node.each do |neighbour|
      add(neighbour)
    end
  end

  def each(&block)
    @nodes.each { |node| block.call(node) }
  end
end

class GraphNode
  
  attr_accessor :value, :neighbours

  def initialize(value, neighbours = [])
    @value = value
    @neighbours = neighbours
  end

  def add_neighbours(neighbours)
    @neighbours += neighbours
  end

  def add_neighbour(neighbour)
    @neighbours << neighbour
  end
end

class Tree

  attr_accessor :value, :left, :right, :parent

  def initialize(value, left = nil, right = nil, parent = nil)
    @value = value
    @left = left
    @right = right
    @parent = parent
  end

  def similar?(other)
    return false if other.nil? || @value != other.value

    if @left.nil?
      return false unless other.left.nil?
    else
      return false unless @left.similar?(other.left)
    end

    if @right.nil?
      return false unless other.right.nil?
    else
      return false unless @right.similar?(other.right)
    end

    return true
  end
end