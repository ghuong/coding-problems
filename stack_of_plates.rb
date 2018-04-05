# CtCI 3.3

require_relative 'stack.rb'

# Data structure that behaves as if it was a single stack,
# but which internally creates a new sub-stack whenever
# one reaches "capacity"
# After ever operation, one of the following must be true:
# 1) There is a single empty sub-stack
# 2) There is one or more non-empty sub-stacks
class SetOfStacks
  def initialize(capacity = 5)
    @stacks = []
    @stacks << Stack.new
    @capacity = capacity
  end

  def push(value)
    if @stacks.last.length == @capacity
      @stacks << Stack.new
    end

    return @stacks.last.push(value)
  end

  def pop
    popAt(@stacks.length - 1)
  end

  # pop from a specific sub-stack
  # if the stack reaches 0 elements, remove it (unless it is the only stack left)
  def popAt(index)
    return unless @stacks.length > index # index must be valid

    popped = @stacks[index].pop
    if @stacks[index].empty?
      @stacks.delete_at(index) unless empty?
    end
    return popped
  end

  def empty?
    @stacks.length == 1 && @stacks.last.length == 0
  end
end

def test
  test_1
end

def test_1
  stacks = SetOfStacks.new
  11.times { |i| stacks.push(i) }
  popped = 5.times.map { stacks.popAt(1) }
  popped += 7.times.map { stacks.pop }
  popped == [9, 8, 7, 6, 5, 10, 4, 3, 2, 1, 0, nil]
end