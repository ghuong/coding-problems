# CtCI 2.1

require_relative 'linked_list.rb'

# Remove duplicates from an unsorted linked list without using a temporary buffer, O(n^2) time
def remove_duplicates(list)
  list.each do |unique_node|
    if unique_node.next
      unique_node.next.each do |possible_duplicate|
        if possible_duplicate.value == unique_node.value
          list.delete_node(possible_duplicate)
        end
      end
    end
  end

  return list
end

# Remove duplicates from an unsorted linked list, O(n) time
def remove_duplicates_2(list)
  seen = {}
  to_delete = []

  list.each do |node|
    if seen[node.value]
      to_delete << node
    end
    seen[node.value] = true
  end

  to_delete.each do |node|
    list.delete_node(node)
  end

  return list
end

def test
  test_1 &&
  test_2 &&
  test_3 &&
  test_4
end

def test_1
  input = DoublyLinkedList.new([0, 1, 2, 3])
  expected = DoublyLinkedList.new([0, 1, 2, 3])
  actual = remove_duplicates(input)
  expected == actual
end

def test_2
  input = DoublyLinkedList.new([0, 1, 3, 0, 2, 2, 3, 0])
  expected = DoublyLinkedList.new([0, 1, 3, 2])
  actual = remove_duplicates(input)
  expected == actual
end

def test_3
  input = DoublyLinkedList.new([0, 1, 2, 3])
  expected = DoublyLinkedList.new([0, 1, 2, 3])
  actual = remove_duplicates_2(input)
  expected == actual
end

def test_4
  input = DoublyLinkedList.new([0, 1, 3, 0, 2, 2, 3, 0])
  expected = DoublyLinkedList.new([0, 1, 3, 2])
  actual = remove_duplicates_2(input)
  expected == actual
end