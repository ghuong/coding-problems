# CtCI 4.6

require_relative 'graph.rb'

# Given a node of a BST where each node links to its parent,
# find the in-order successor
def inorder_successor(tree_node, ignore_right_subtree = false)
  return if tree_node.nil?

  if !ignore_right_subtree && !tree_node.right.nil?
    return leftmost_node(tree_node.right)
  else
    parent = tree_node.parent
    return if parent.nil?
    return parent if parent.left == tree_node
    return inorder_successor(parent, true)
  end
end

def leftmost_node(tree)
  node = tree
  until node.left.nil?
    node = node.left
  end
  return node
end

def test
  test_1 &&
  test_2 &&
  test_3
end

def test_1
  d = Tree.new(2)
  c = Tree.new(3, d, nil)
  b = Tree.new(4, c, nil)
  a = Tree.new(1, nil, b)
  d.parent = c
  c.parent = b
  b.parent = a
  expected = d
  actual = inorder_successor(a)
  expected == actual
end

def test_2
  e = Tree.new(10)
  d = Tree.new(2)
  c = Tree.new(3, d, nil)
  b = Tree.new(4, c, e)
  a = Tree.new(1, nil, b)
  d.parent = c
  c.parent = b
  b.parent = a
  e.parent = b
  expected = b
  actual = inorder_successor(c)
  expected == actual
end

def test_3
  e = Tree.new(10)
  d = Tree.new(2)
  c = Tree.new(3, nil, nil)
  b = Tree.new(4, c, nil)
  a = Tree.new(1, b, d)
  d.parent = a
  c.parent = b
  b.parent = a
  e.parent = b
  expected = a
  actual = inorder_successor(e)
  expected == actual
end