# CtCI 1.5

# Returns true iff given strings are one (or zero) "edits" away
# Where an "edit" means insert, remove, or replace one character
def one_away?(s, t)
  if (s.length - t.length).abs > 1
    return false
  end

  if s == t
    return true
  end

  if s.length == t.length
    one_replace_away?(s, t)
  else
    one_insert_away?(s, t)
  end
end

def one_replace_away?(s, t)
  has_replaced = false
  s.each_char.each_with_index do |c, i|
    if c != t[i]
      if has_replaced
        return false
      end
      has_replaced = true
    end
  end

  return true
end

def one_insert_away?(s, t)
  shorter = s
  longer = t
  if s.length > t.length
    shorter = t
    longer = s
  end

  has_inserted = false
  i = 0
  j = 0
  while i < shorter.length
    if shorter[i] == longer[j]
      i += 1
    else
      if has_inserted
        return false
      end
      has_inserted = true
    end

    j += 1
  end

  return true
end