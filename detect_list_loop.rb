# CtCI 2.8

require_relative 'linked_list.rb'

# Given singly-linked list, determine if there is a loop. If so, return the
# start of the loop. Else, return nil.
# O(n) time, O(1) space, where n is the number of unique nodes in list
def detect_loop(list)
  return unless list

  tortoise = list
  hare = list

  loop do
    tortoise = tortoise.next
   return unless hare.next
    hare = hare.next.next
   break if tortoise.equal? hare
  end

  tortoise_2 = list
  until tortoise.equal? tortoise_2
    tortoise = tortoise.next
    tortoise_2 = tortoise_2.next
  end

  return tortoise
end

def test
  test_1 &&
  test_2 &&
  test_3 &&
  test_4 &&
  test_5 &&
  test_6 &&
  test_7 &&
  test_8 &&
  test_9
end

def test_1
  list, cycle = cycle_list(0, 1)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_2
  list, cycle = cycle_list(0, 2)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_3
  list, cycle = cycle_list(1, 1)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_4
  list, cycle = cycle_list(1, 2)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_5
  list, cycle = cycle_list(2, 1)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_6
  list, cycle = cycle_list(2, 2)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_7
  list, cycle = cycle_list(3, 8)
  actual = detect_loop(list)
  cycle.equal? actual
end

def test_8
  list = LinkedListNode::array_to_list([0, 0, 0])
  actual = detect_loop(list)
  actual.nil?
end

def test_9
  list, cycle = cycle_list(10, 3)
  actual = detect_loop(list)
  cycle.equal? actual
end

def cycle_list(pre_cycle_length, cycle_length)
  return unless cycle_length > 0
  tail = LinkedListNode.new(0)
  cycle = tail
  (cycle_length - 1).times do
    cycle = LinkedListNode.new(0, cycle)
  end
  tail.next = cycle
  pre_cycle = cycle
  pre_cycle_length.times do
    pre_cycle = LinkedListNode.new(0, pre_cycle)
  end
  return pre_cycle, cycle
end