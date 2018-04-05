# CtCI 1.2

# Returns whether given strings are permutation of one another
def permutation?(s1, s2)
  if s1.length != s2.length
    return false
  end

  h = Hash.new(0)
  s1.each_char do |char|
    h[char] += 1
  end

  s2.each_char do |char|
    h[char] -= 1
    if h[char] < 0
      return false
    end
  end

  return true
end