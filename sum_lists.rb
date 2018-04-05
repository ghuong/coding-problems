# CtCI 2.5

require_relative 'linked_list.rb'

# Given two lists representing numbers,
# where each list's value is a digit of that number,
# from most significant digit to least significant
# Return a list representing their sum
# O(n) time, where n is length of longer list
# O(n) space due to recursion stack
def sum_lists(list1, list2)
  return list1 unless list2
  return list2 unless list1

  sum = sum_lists_helper(list1, list1.count, list2, list2.count)

  if sum.value >= 10
    sum.value -= 10
    return LinkedListNode.new(1, sum)
  else
    return sum
  end
end

# Returns sum of two lists, both non-empty
def sum_lists_helper(list1, length1, list2, length2)
  # Base case
  return LinkedListNode.new(list1.value + list2.value) if length1 == 1

  sum = nil
  if length1 > length2
    sum = sum_lists_helper(list1.next, length1 - 1, list2, length2)
  elsif length2 > length1
    sum = sum_lists_helper(list1, length1, list2.next, length2 - 1)
  else
    sum = sum_lists_helper(list1.next, length1 - 1, list2.next, length2 - 1)
  end

  digit_sum = 0
  if length1 >= length2
    digit_sum += list1.value
  end

  if length2 >= length1
    digit_sum += list2.value
  end

  if sum.value >= 10
    sum.value -= 10
    return LinkedListNode.new(1 + digit_sum, sum)
  else
    return LinkedListNode.new(digit_sum, sum)
  end
end

def test
  test_1 &&
  test_2 &&
  test_3
end

def test_1
  list1 =    LinkedListNode::array_to_list([   9, 7, 8])
  list2 =    LinkedListNode::array_to_list([      2, 8])
  expected = LinkedListNode::array_to_list([1, 0, 0, 6])
  actual = sum_lists(list1, list2)
  expected == actual
end

def test_2
  list1 =    LinkedListNode::array_to_list([   7, 8])
  list2 =    LinkedListNode::array_to_list([   7, 1])
  expected = LinkedListNode::array_to_list([1, 4, 9])
  actual = sum_lists(list1, list2)
  expected == actual
end

def test_3
  list1 =    LinkedListNode::array_to_list([1, 8])
  list2 =    LinkedListNode::array_to_list([1, 3])
  expected = LinkedListNode::array_to_list([3, 1])
  actual = sum_lists(list1, list2)
  expected == actual
end
