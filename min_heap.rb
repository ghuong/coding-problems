# My implementation of Min Heap

class MinHeap

  INVALID_INDEX = -1

  def initialize
    @tree = []
  end

  def insert(value)
    @tree << value
    to_bubble_up = @tree.length - 1
    loop do
      parent_index = parent(to_bubble_up)
     break if parent_index == INVALID_INDEX || 
              @tree[parent_index] < @tree[to_bubble_up]
      swap(parent_index, to_bubble_up)
      to_bubble_up = parent_index
    end
    return value
  end

  def extract_min
    min = @tree[0]
    swap(0, @tree.length - 1)
    @tree.pop

    to_bubble_down = 0
    loop do
      min_child_index = min_child(to_bubble_down)
     break if min_child_index == INVALID_INDEX ||
              @tree[to_bubble_down] < @tree[min_child_index]
      swap(to_bubble_down, min_child_index)
      to_bubble_down = min_child_index
    end

    return min
  end

  private

    # Return index of parent, or -1 if there is no parent
    def parent(index)
      case index
      when 0
        INVALID_INDEX
      else
        (index - 1) / 2
      end
    end

    # Return index of left child, or -1 if there is none
    def left_child(index)
      left = index * 2 + 1
      if left >= @tree.length
        return INVALID_INDEX
      else
        return left
      end
    end

    # Return index of right child, or -1 if there is none
    def right_child(index)
      right = index * 2 + 2
      if right >= @tree.length
        return INVALID_INDEX
      else
        return right
      end
    end

    # Swap two values, assuming both are valid
    def swap(index1, index2)
      @tree[index1], @tree[index2] = @tree[index2], @tree[index1]
    end

    # Return index of smaller child, or -1 if there is no child
    def min_child(index)
      left_child_index = left_child(index)
      right_child_index = right_child(index)
      min_child_index = left_child_index
      if right_child_index != INVALID_INDEX && @tree[right_child_index] < @tree[left_child_index]
        min_child_index = right_child_index
      end
      return min_child_index
    end
end

def test
  test_1
end

def test_1
  mh = MinHeap.new
  mh.insert(7)
  mh.insert(1)
  mh.insert(3)
  mh.insert(0)
  mh.insert(6)
  mh.insert(2)
  mh.insert(4)
  
  mins = []
  4.times { mins << mh.extract_min }

  mh.insert(5)
  mh.insert(0)

  5.times { mins << mh.extract_min }

  mins == [0, 1, 2, 3, 0, 4, 5, 6, 7]
end