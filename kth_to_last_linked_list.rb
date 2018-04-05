# CtCI 2.1

require_relative 'linked_list.rb'

# Find K-th to last element in a singly linked list
def kth_to_last(list, k)
  return unless k >= 1 && k <= list.length

  jumps = list.length - k

  node = list.head
  jumps.times do |i|
    node = node.next
  end
  return node
end