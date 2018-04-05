# Personal implementation of a double linked list
class DoublyLinkedList
  include Enumerable

  attr_reader :head, :tail, :length

  def initialize(values = nil)
    @head = nil
    @tail = nil
    @length = 0

    if values
      values.each do |value|
        insert(value)
      end
    end
  end

  # Append to front of the list, return Node, O(1)
  def insert_front(value)
    if @head
      @head = Node.new(value, nil, @head)
    else
      @head = Node.new(value)
      @tail = @head
    end
    @length += 1
    return @head
  end

  # Append to end of list, return Node, O(1)
  def insert(value)
    if @tail
      @tail.next = Node.new(value, @tail)
      @tail = @tail.next
    else
      @head = Node.new(value)
      @tail = @head
    end
    @length += 1
    return @tail
  end

  # Append value immediately after a node with given key, and return it, O(n)
  def insert_after(key, to_insert)
    insert_after_node(find(key), to_insert)
  end

  # Append value immediately before a node with given key, and return it, O(n)
  def insert_before(key, to_insert)
    insert_before_node(find(key), to_insert)
  end

  # Search for value, delete it, then return it, O(n)
  def delete(value)
    delete_node(find(value))
  end

  def pop
    delete_node(@tail)
  end

  # Find node with given value, O(n)
  def find(value)
    node = @head
    while node
      if node.value == value
        return node
      end
      node = node.next
    end

    return nil
  end

  # Insert after given node, O(1)
  # Naively assumes that given node is actually part of list
  def insert_after_node(node, to_insert)
    return unless node

    new_node = Node.new(to_insert, node, node.next)

    if node.next
      node.next.prev = new_node
    end

    if node == @tail
      @tail = new_node
    end

    node.next = new_node
    @length += 1
    return new_node
  end

  # Insert before given node, O(1)
  # Naively assumes that given node is actually part of list
  def insert_before_node(node, to_insert)
    return unless node

    new_node = Node.new(to_insert, node.prev, node)

    if node.prev
      node.prev.next = new_node
    end

    if node == @head
      @head = new_node
    end

    node.prev = new_node
    @length += 1
    return new_node
  end

  # Delete the given node, O(1)
  # Naively assumes that given node is actually part of list
  def delete_node(node)
    return unless node

    if node.prev
      node.prev.next = node.next
    end

    if node.next
      node.next.prev = node.prev
    end

    if node == @head
      @head = node.next
    end

    if node == @tail
      @tail = node.prev
    end

    @length -= 1
    return node
  end

  def each(&block)
    node = @head
    while node
      block.call(node)
      node = node.next
    end
  end

  def empty?
    @length == 0
  end

  def ==(other)
    return false unless @length == other.length

    n1 = @head
    n2 = other.head

    while n1 && n2
      return false unless n1.value == n2.value
      n1 = n1.next
      n2 = n2.next
    end

    return true
  end

  class Node
    include Enumerable

    attr_accessor :prev, :next, :value

    def initialize(value, prev = nil, next_node = nil)
      @value = value
      @prev = prev
      @next = next_node
    end

    def each(&block)
      node = self
      while node
        block.call(node)
        node = node.next
      end
    end
  end
end

# Simple singly-linked list
class LinkedListNode
  include Enumerable

  attr_accessor :value, :next
  
  def initialize(value, _next = nil)
    @value = value
    @next = _next
  end

  def ==(other)
    !other.nil? && @value == other.value && @next == other.next
  end

  def each(&block)
    node = self
    while node
      block.call(node)
      node = node.next
    end
  end

  def self.array_to_list(array)
    return if array.nil? || array.empty?

    list = LinkedListNode.new(array[0])
    tail = list
    array[1..-1].each do |element|
      tail.next = LinkedListNode.new(element)
      tail = tail.next
    end
    return list
  end
end