# CtCI 1.4

# Return true iff string is a permutation of a palindrome
def palindrome_permutation?(s)
  s = s.gsub(/[^a-z]/i, '').downcase
  h = Hash.new(0)
  odd = 0

  s.each_char do |c|
    h[c] += 1
    if h[c].odd?
      odd += 1
    else
      odd -= 1
    end
  end

  return odd <= 1
end