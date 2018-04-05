# CtCI 4.8

require_relative 'graph.rb'

# Return first common ancestor of two nodes in a tree
# O(n) time - constant amount of work done for each node
# O(n) space in the worst-case (skinny tree),
# O(logn) space average-case (balanced tree)
def first_common_ancestor(tree, a, b)
  contains_a, contains_b, fca = first_common_ancestor_helper(tree, a, b)
  return fca
end

# Returns three values:
# Whether the tree contains a
# Whether the tree contains b
# The first common ancestor of a, b in this tree or nil if there is none
def first_common_ancestor_helper(tree, a, b)
  return false, false, nil if tree.nil?

  a_in_left, b_in_left, fca_left = first_common_ancestor_helper(tree.left, a, b)
  a_in_right, b_in_right, fca_right = first_common_ancestor_helper(tree.right, a, b)

  contains_a = a_in_left || a_in_right || tree == a
  contains_b = b_in_left || b_in_right || tree == b

  fca = nil
  if fca_left
    fca = fca_left
  elsif fca_right
    fca = fca_right
  elsif contains_a && contains_b
    fca = tree
  end

  return contains_a, contains_b, fca
end

def test
  test_1 &&
  test_2 &&
  test_3 &&
  test_4
end

def test_1
  a = Tree.new('a', Tree.new('x'), Tree.new('x'))
  bl = Tree.new('bl', Tree.new('x'), a)
  b = Tree.new('b', bl, Tree.new('x'))
  root = Tree.new('root', b, Tree.new('x'))
  expected = b
  actual = first_common_ancestor(root, a, b)
  expected == actual
end

def test_2
  a = Tree.new('a', Tree.new('x'), Tree.new('x'))
  bl = Tree.new('bl', Tree.new('x'), a)
  b = Tree.new('b')
  rl = Tree.new('rl', bl, b)
  root = Tree.new('root', rl, Tree.new('x'))
  expected = rl
  actual = first_common_ancestor(root, a, b)
  expected == actual
end

def test_3
  a = Tree.new('a', Tree.new('x'), Tree.new('x'))
  bl = Tree.new('bl', Tree.new('x'), a)
  b = Tree.new('b')
  rl = Tree.new('rl', bl, b)
  root = Tree.new('root', rl, Tree.new('x'))
  expected = a
  actual = first_common_ancestor(root, a, a)
  expected == actual
end

def test_4
  a = Tree.new('a', Tree.new('x'), Tree.new('x'))
  bl = Tree.new('bl', Tree.new('x'), a)
  b = Tree.new('b')
  rl = Tree.new('rl', bl, nil)
  root = Tree.new('root', rl, Tree.new('x'))
  expected = nil
  actual = first_common_ancestor(root, a, b)
  expected == actual
end