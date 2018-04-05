# Merge sort

require_relative 'stack.rb'

def merge_sort(array)
  # Base case
  return array if array.length <= 1

  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid..-1])
  merge(left, right)
end

class Problem
  attr_reader :problem, :solution
  def initialize(problem)
    @problem = problem
    @subproblems = Stack.new
    init_subproblems
    @subsolutions = []
    @solution = nil
    set_basecase_solution if @subproblems.empty?
  end

  def solved?
    @subproblems.empty?
  end

  def add_subsolution(solution)
    @subsolutions << solution
    solve if solved?
  end

  def pop_subproblem
    @subproblems.pop
  end

  protected
    # Solve the problem (assume that all subsolutions are provided, and this is not the base case)
    def solve
    end

    # Push subproblems onto stack, or leave empty if this is base case
    def init_subproblems
      # Default behaviour is to split the problem into two halves (assuming an array)
      if @problem.length > 1
        mid = @problem.length / 2
        @subproblems.push(@problem[mid..-1]) # Solve right half first
        @subproblems.push(@problem[0...mid]) # Solve left half first
      end
    end

    # Set the solution, assuming this is a base case
    def set_basecase_solution
      @solution = @problem
    end
end

class MergeSortProblem < Problem
  protected
    def solve
      @solution = merge(@subsolutions[0], @subsolutions[1])
    end
end

# Non-recursive solution using stack
def merge_sort_stack(array)
  subproblems = Stack.new
  subproblems.push(MergeSortProblem.new(array))
  solution = nil

  until subproblems.empty?
    subproblem = subproblems.peek

    if subproblem.solved?
      solution = subproblems.pop.solution
      subproblems.peek.add_subsolution(solution) unless subproblems.empty?
      next
    end

    subproblems.push(MergeSortProblem.new(subproblem.pop_subproblem))
  end

  return solution
end

def merge(arr1, arr2)
  p1 = 0
  p2 = 0
  sorted = []
  until p1 >= arr1.length && p2 >= arr2.length
    if p1 >= arr1.length
      sorted << arr2[p2]
      p2 += 1
    elsif p2 >= arr2.length
      sorted << arr1[p1]
      p1 += 1
    elsif arr2[p2] < arr1[p1]
      sorted << arr2[p2]
      p2 += 1
    else
      sorted << arr1[p1]
      p1 += 1
    end
  end
  return sorted
end

def test_recursive
  input = [5, 1, 0, 6, 4, 2, 3]
  expected = [0, 1, 2, 3, 4, 5, 6]
  actual = merge_sort(input)
  expected == actual
end

def test_stack
  input = [5, 1, 0, 6, 4, 2, 3]
  expected = [0, 1, 2, 3, 4, 5, 6]
  actual = merge_sort_stack(input)
  expected == actual
end