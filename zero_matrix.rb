# Given an MxN matrix, if an element is 0,
# set its entire row and column to 0
def zeroify(matrix)
  rows_with_zero = 0
  columns_with_zero = 0

  matrix.each_with_index do |row, r|
    row.each_with_index do |element, c|
      if element == 0
        rows_with_zero |= (1 << r)
        columns_with_zero |= (1 << c)
      end
    end
  end

  matrix.each_with_index do |row, r|
    row.each_with_index do |element, c|
      if rows_with_zero & (1 << r) > 0 || columns_with_zero & (1 << c) > 0
        matrix[r][c] = 0
      end
    end
  end
end

def test
  test_1 &&
  test_2
end

def test_1
  input = [[1, 1, 1], [1, 1, 1], [1, 0, 1], [1, 1, 1]]
  expected = [[1, 0, 1], [1, 0, 1], [0, 0, 0], [1, 0, 1]]
  actual = zeroify(input)
  expected == actual
end

def test_2
  input = [[1, 1, 1], [1, 1, 1], [1, 0, 0], [1, 0, 1]]
  expected = [[1, 0, 0], [1, 0, 0], [0, 0, 0], [0, 0, 0]]
  actual = zeroify(input)
  expected == actual
end