# CtCI 1.3

# Replace all spaces in string with %20
def replace(s, length, from = ' ', to = '%20')
  s = s[0..length-1]
  num_extra_chars = s.count(from) * (to.length - from.length)
  s += ' ' * num_extra_chars

  i = length - 1 + num_extra_chars
  while i >= 0
    if s[i - num_extra_chars] == from
      s[(i-to.length+1)..i] = to
      num_extra_chars -= to.length - from.length
      i -= to.length
    else
      s[i] = s[i - num_extra_chars]
      i -= 1
    end
  end

  return s
end