# CtCI 4.4

require_relative 'graph.rb'

# Check if binary tree is balanced:
# (height of two subtrees of any node never differ by more than 1)
def check_balanced_tree(tree)
  balanced, height = check_balanced_tree_helper(tree)
  return balanced
end

# Returns whether binary tree is balanced, as well as the height of the tree
def check_balanced_tree_helper(tree)
  return true, 0 if tree.nil?

  left_balanced, left_height = check_balanced_tree_helper(tree.left)
  right_balanced, right_height = check_balanced_tree_helper(tree.right)

  balanced = left_balanced && right_balanced && (left_height - right_height).abs <= 1
  return balanced, [left_height, right_height].max + 1
end

def test
  test_1 &&
  test_2
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
  check_balanced_tree(a) == false
end

def test_2
  cr = Tree.new('cr')
  bl = Tree.new('bl')
  f = Tree.new('f')
  d = Tree.new('d', f, nil)
  b = Tree.new('b', bl, d)
  g = Tree.new('g')
  h = Tree.new('h')
  e = Tree.new('e', g, h)
  c = Tree.new('c', e, cr)
  a = Tree.new('a', b, c)
  check_balanced_tree(a) == true
end