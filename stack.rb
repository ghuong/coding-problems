# My implementation of a stack
class Stack
  attr_reader :top, :length
  
  def initialize
    @length = 0
  end

  def push(value)
    @top = StackNode.new(value, @top)
    @length += 1
    return @top
  end

  def pop
    popped = @top
    if @top
      @top = @top.next
      @length -= 1
      return popped.value
    end
    return nil
  end

  def empty?
    @top.nil?
  end

  def peek
    if @top
      @top.value
    else
      nil
    end
  end

  class StackNode
    attr_accessor :value, :next
    def initialize(value, _next = nil)
      @value = value
      @next = _next
    end
  end
end