# CtCI 4.2

require_relative 'graph.rb'

# Given sorted (increasing-order) array of unique integers,
# Return a Binary Search Tree of minimal height
# O(n) time, where n is length of array
# O(log(n)) additional space for recursive stack frames
def minimal_tree(sorted_array)
  minimal_tree_helper(sorted_array, 0, sorted_array.length - 1)
end

def minimal_tree_helper(sorted_array, first, last)
  return if first > last

  middle = (first + last) / 2
  left = minimal_tree_helper(sorted_array, first, middle - 1)
  right = minimal_tree_helper(sorted_array, middle + 1, last)
  return Tree.new(sorted_array[middle], left, right)
end

def test
  test_1 &&
  test_2 &&
  test_3 &&
  test_4
end

def test_1
  input = [0, 1, 2, 3, 4, 5, 6]
  expected = Tree.new(3, 
              Tree.new(1,
                Tree.new(0), 
                Tree.new(2)
              ),
              Tree.new(5,
                Tree.new(4), 
                Tree.new(6)
              )
            )
  actual = minimal_tree(input)

  expected.similar?(actual)
end

def test_2
  input = [1, 2, 3, 4, 5, 6]
  expected = Tree.new(3, 
              Tree.new(1,
                nil, 
                Tree.new(2)
              ),
              Tree.new(5,
                Tree.new(4), 
                Tree.new(6)
              )
            )
  actual = minimal_tree(input)

  expected.similar?(actual)
end

def test_3
  input = []
  actual = minimal_tree(input)

  actual.nil?
end

def test_4
  input = [0]
  expected = Tree.new(0)
  actual = minimal_tree(input)

  expected.similar?(actual)
end