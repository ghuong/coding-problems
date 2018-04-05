# CtCI 2.6

require_relative 'linked_list.rb'

# Check if linked list is a palindrome, O(n)
def palindrome?(list)
  return true if list.nil?

  reverse = LinkedListNode.new(list.value)
  node = list.next
  while node
    reverse = LinkedListNode.new(node.value, reverse)
    node = node.next
  end

  while list
    return false unless list.value == reverse.value
    list = list.next
    reverse = reverse.next
  end

  return true
end

def test
  test_1 &&
  test_2 &&
  test_3 &&
  test_4 &&
  test_5 &&
  test_6
end

def test_1
  input = LinkedListNode::array_to_list([])
  palindrome?(input)
end

def test_2
  input = LinkedListNode::array_to_list([0])
  palindrome?(input)
end

def test_3
  input = LinkedListNode::array_to_list([0, 0])
  palindrome?(input)
end

def test_4
  input = LinkedListNode::array_to_list([0, 1, 2, 2, 1, 0])
  palindrome?(input)
end

def test_5
  input = LinkedListNode::array_to_list([0, 1, 2, 3, 2, 1, 0])
  palindrome?(input)
end

def test_6
  input = LinkedListNode::array_to_list([0, 1, 2, 3, 3, 1, 0])
  !palindrome?(input)
end