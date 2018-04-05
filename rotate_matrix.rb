# Rotate NxN matrix 90 degrees
# Assumption: matrix is an N-array of N-arrays
def rotate_matrix(matrix)
  n = matrix.length
  
  (n / 2).times do |j|
    (j..n-2-j).each do |i|
      top = matrix[j][i]
      matrix[j][i]         = matrix[n-1-i][j]     # copy left half into top half
      matrix[n-1-i][j]     = matrix[n-1-j][n-1-i] # bottom to left
      matrix[n-1-j][n-1-i] = matrix[i][n-1-j]     # right to bottom
      matrix[i][n-1-j]     = top                  # top to right
    end
  end

  return matrix
end

def print_matrix(matrix)
  matrix.each do |row|
    row.each do |element|
      print "#{element} "
    end
    puts
  end
end

def test
  test_1 &&
  test_2
end

def test_1
  input = [[0, 1, 2, 3, 4], ['a', 'b', 'c', 'd', 'e'], [5, 6, 7, 8, 9], ['f', 'g', 'h', 'i', 'j'], ['k','l', 'm', 'n', 'o']]
  expected = [["k", "f", 5, "a", 0], ["l", "g", 6, "b", 1], ["m", "h", 7, "c", 2], ["n", "i", 8, "d", 3], ["o", "j", 9, "e", 4]]
  actual = rotate_matrix(input)
  expected == actual
end

def test_2
  input = [[0, 1, 2, 3], ['a', 'b', 'c', 'd'], [5, 6, 7, 8], ['f', 'g', 'h', 'i']]
  expected = [["f", 5, "a", 0], ["g", 6, "b", 1], ["h", 7, "c", 2], ["i", 8, "d", 3]]
  actual = rotate_matrix(input)
  expected == actual
end
