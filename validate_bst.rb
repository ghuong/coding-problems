# CtCI 4.5

require_relative 'graph.rb'

# Check if binary tree is a BST
# O(n) time, where n is the number of nodes in tree
# O(log(n)) space for recursive stack
def validate_bst(tree)
  is_bst, min_value, max_value = validate_bst_helper(tree)
  return is_bst
end

# Check if binary tree is a BST, and also return the max and min values if so
def validate_bst_helper(tree)
  return true, nil, nil if tree.nil?

  is_left_bst, left_min, left_max = validate_bst_helper(tree.left)
  is_right_bst, right_min, right_max = validate_bst_helper(tree.right)

  is_bst = is_left_bst && is_right_bst && 
           (tree.left.nil? || left_max <= tree.value) && 
           (tree.right.nil? || right_min > tree.value)
  min_value = tree.left.nil? ? tree.value : left_min
  max_value = tree.right.nil? ? tree.value : right_max

  return is_bst, min_value, max_value
end

def test
  test_1 &&
  test_2
end

def test_1
  f = Tree.new(1)
  d = Tree.new(2, f, nil)
  b = Tree.new(0, nil, d)
  g = Tree.new(4)
  h = Tree.new(5)
  e = Tree.new(5, g, h)
  c = Tree.new(7, e, nil)
  a = Tree.new(3, b, c)
  validate_bst(a) == false
end

def test_2
  f = Tree.new(1)
  d = Tree.new(2, f, nil)
  b = Tree.new(0, nil, d)
  g = Tree.new(4)
  h = Tree.new(6)
  e = Tree.new(5, g, h)
  c = Tree.new(7, e, nil)
  a = Tree.new(3, b, c)
  validate_bst(a) == true
end