# CtCI 4.3

require_relative 'graph.rb'
require_relative 'linked_list.rb'

# Given a binary tree, return an array of linked lists
# of nodes for each depth-level of the tree
# O(n) time, where n is the number of nodes in tree
# O(n) additional space (the return value)
def list_of_depths(binary_tree)
  return [] if binary_tree.nil?

  lists = [DoublyLinkedList.new([binary_tree])]

  loop do
    child_nodes = DoublyLinkedList.new
    lists[-1].each do |node|
      child_nodes.insert(node.value.left) unless node.value.left.nil?
      child_nodes.insert(node.value.right) unless node.value.right.nil?
    end

   break if child_nodes.empty?

    lists << child_nodes
  end

  return lists
end

def test
  test_1
end

def test_1
  f = Tree.new('f')
  d = Tree.new('d', f, nil)
  b = Tree.new('b', nil, d)
  g = Tree.new('g')
  h = Tree.new('h')
  e = Tree.new('e', g, h)
  c = Tree.new('c', e, nil)
  a = Tree.new('a', b, c)
  expected = [
    DoublyLinkedList.new([a]),
    DoublyLinkedList.new([b, c]),
    DoublyLinkedList.new([d, e]),
    DoublyLinkedList.new([f, g, h]),
  ]
  actual = list_of_depths(a)

  expected == actual
end