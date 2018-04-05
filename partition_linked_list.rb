# CtCI 2.4

require_relative 'linked_list.rb'

# Partition singly-linked list such that all nodes less than x come before all nodes greater than or equal to x
# Solution 1: use two buffers for left/right partition, then merge them, O(n) time, O(n) space
def partition_1(list, x)
  left = { "head" => nil, "tail" => nil }
  right = { "head" => nil, "tail" => nil }

  node = list
  while node
    partition = left
    if node.value >= x
      partition = right
    end

    if partition["tail"]
      partition["tail"].next = LinkedListNode.new(node.value)
      partition["tail"] = partition["tail"].next
    else
      partition["head"] = LinkedListNode.new(node.value)
      partition["tail"] = partition["head"]
    end

    node = node.next
  end

  if left["tail"]
    left["tail"].next = right["head"]
    return left["head"]
  else
    return right["head"]
  end
end

def test
  test_1 &&
  test_2 &&
  test_3 &&
  test_4 &&
  test_5
end

def test_1
  x = 0
  list = LinkedListNode::array_to_list([1, -2, 0, -3, 0, -1, 2])
  expected = LinkedListNode::array_to_list([-2, -3, -1, 1, 0, 0, 2])
  actual = partition_1(list, x)
  expected == actual
end

def test_2
  x = 0
  list = LinkedListNode::array_to_list([1, 1, 1])
  expected = LinkedListNode::array_to_list([1, 1, 1])
  actual = partition_1(list, x)
  expected == actual
end

def test_3
  x = 0
  list = LinkedListNode::array_to_list([-1, -1, -1])
  expected = LinkedListNode::array_to_list([-1, -1, -1])
  actual = partition_1(list, x)
  expected == actual
end

def test_4
  x = 0
  list = LinkedListNode::array_to_list([])
  expected = LinkedListNode::array_to_list([])
  actual = partition_1(list, x)
  expected == actual
end

def test_5
  x = 0
  list = LinkedListNode::array_to_list([1])
  expected = LinkedListNode::array_to_list([1])
  actual = partition_1(list, x)
  expected == actual
end

