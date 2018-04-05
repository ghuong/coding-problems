# CtCI 1.6

# Compress the string, like so: aabcccccaaa -> a2b1c5a3
# Or return the original string if it would not become smaller
# Assume string has only uppercase and lowercase letters
def compress_string(s)
  compressed = s[0]
  repeating_char = s[0]
  streak = 0
  
  s.each_char do |c|
    if c == repeating_char
      streak += 1
    else
      compressed << streak.to_s
      repeating_char = c
      streak = 1
      compressed << c
    end
  end

  compressed << streak.to_s

  if s.length < compressed.length
    return s
  else
    return compressed
  end
end