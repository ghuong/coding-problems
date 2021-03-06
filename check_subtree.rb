# CtCI 4.10

require_relative 'graph.rb'

# Given two large binary trees, T1 much larger than T2
# Determine if T2 is a subtree of T1
# T2 is a subtree of T1 if there exists a node n in T1 whose subtree
# is identical to T2
# O(T1 + T2) runtime, O(T1 + T2) additional space
def check_subtree(t1, t2)
  # Pre-compute sizes of each subtree in t1 and t2
  t1_sizes = compute_subtree_sizes(t1)
  t2_sizes = compute_subtree_sizes(t2)

  # Check if t2 is subtree of t1
  check_subtree_helper(t1, t2, t1_sizes, t2_sizes)
end

def compute_subtree_sizes(tree)
  return nil if tree.nil?

  left_subtree_size_node = compute_subtree_sizes(tree.left)
  right_subtree_size_node = compute_subtree_sizes(tree.right)

  left_subtree_size = left_subtree_size_node.nil? ? 0 : left_subtree_size_node.value
  right_subtree_size = right_subtree_size_node.nil? ? 0 : right_subtree_size_node.value

  subtree_size = 1 + left_subtree_size + right_subtree_size
  return Tree.new(subtree_size, left_subtree_size_node, right_subtree_size_node)
end

def check_subtree_helper(t1, t2, t1_sizes, t2_sizes)
  return true if t1.nil? && t2.nil? # both are nil
  return false if t1.nil? || t2.nil? # only one is nil

  return false if t1_sizes.value < t2_sizes.value # t1 is smaller

  if t1_sizes.value == t2_sizes.value # same size, possible match
    return are_trees_equal?(t1, t2, t1_sizes, t2_sizes)
  else # t1 is bigger, try recursing on the left and right
    return check_subtree_helper(t1.left, t2, t1_sizes.left, t2_sizes) ||
           check_subtree_helper(t1.right, t2, t1_sizes.right, t2_sizes)          
  end
end

def are_trees_equal?(t1, t2, t1_sizes, t2_sizes)
  return true if t1.nil? && t2.nil? # both are nil
  return false if t1.nil? || t2.nil? # only one is nil

  return false if t1_sizes.value != t2_sizes.value # t1 is different size

  return t1.value == t2.value &&
         are_trees_equal?(t1.left, t2.left, t1_sizes.left, t2_sizes.left) &&
         are_trees_equal?(t1.right, t2.right, t1_sizes.right, t2_sizes.right)
end

def test
  test1 &&
  test2
end

def test1
  t1 = Tree.new(10, 
        Tree.new(10, 
          Tree.new(5),
          Tree.new(10,
            Tree.new(9,
              Tree.new(10,
                Tree.new(9),
                Tree.new(10,
                  Tree.new(10)
                )
              )
            ),
            Tree.new(10,
              Tree.new(9),
              Tree.new(10,
                nil,
                Tree.new(9)
              )
            )
          )
        ),
        Tree.new(10,
          Tree.new(9),
          Tree.new(10,
            Tree.new(9),
            Tree.new(10,
              nil,
              Tree.new(10)
            )
          )
        )
       )
  t2 = Tree.new(10,
        Tree.new(9),
        Tree.new(10,
          nil,
          Tree.new(9)
        )
       )
  return check_subtree(t1, t2)
end

def test2
  t1 = Tree.new(10, 
        Tree.new(10, 
          Tree.new(5),
          Tree.new(10,
            Tree.new(9,
              Tree.new(10,
                Tree.new(9),
                Tree.new(10,
                  Tree.new(10)
                )
              )
            ),
            Tree.new(10,
              Tree.new(9),
              Tree.new(10,
                nil,
                Tree.new(10)
              )
            )
          )
        ),
        Tree.new(10,
          Tree.new(9),
          Tree.new(10,
            Tree.new(9),
            Tree.new(10,
              nil,
              Tree.new(10)
            )
          )
        )
       )
  t2 = Tree.new(10,
        Tree.new(9),
        Tree.new(10,
          nil,
          Tree.new(9)
        )
       )
  return !check_subtree(t1, t2)
end