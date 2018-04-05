# CtCI 2.7

require_relative 'linked_list.rb'

# Return the first intersecting node of two lists, or nil otherwise
# Recursive solution: runtime O(a + b), a, b are lengths of the lists
# O(a) space (for recursive stack), where a is length of longer list
def intersection(list1, list2)
  return nil unless list1 && list2

  intersection_helper(list1, list1.count, list2, list2.count)
end

def intersection_helper(list1, length1, list2, length2)
  # Base case
  if length1 == 1 && length2 == 1
    if list1.equal? list2
      return list1
    else
      return nil
    end
  end

  intersecting_node = nil

  if length1 == length2
    intersecting_node = intersection_helper(list1.next, length1 - 1, list2.next, length2 - 1)
  elsif length1 > length2
    intersecting_node = intersection_helper(list1.next, length1 - 1, list2, length2)
  else
    intersecting_node = intersection_helper(list1, length1, list2.next, length2 - 1)
  end

  if list1.equal? list2
    return list1
  else
    return intersecting_node
  end
end

def test
  test_1 &&
  test_2 &&
  test_3
end

def test_1
  intersecting_node = LinkedListNode::array_to_list([0, 0, 0])
  list1 = LinkedListNode.new(0, intersecting_node)
  list2 = LinkedListNode.new(0, intersecting_node)
  3.times do
    list1 = LinkedListNode.new(0, list1)
  end
  actual = intersection(list1, list2)
  actual.equal? intersecting_node
end

def test_2
  intersecting_node = LinkedListNode::array_to_list([0])
  list1 = LinkedListNode.new(0, intersecting_node)
  list2 = intersecting_node
  3.times do
    list1 = LinkedListNode.new(0, list1)
  end
  actual = intersection(list1, list2)
  actual.equal? intersecting_node
end

def test_3
  intersecting_node = LinkedListNode::array_to_list([0, 0])
  list1 = intersecting_node
  list2 = intersecting_node
  actual = intersection(list1, list2)
  actual.equal? intersecting_node
end