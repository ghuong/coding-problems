# CtCI p.71

# Print all permutations of a string, assuming all characters are unique
def print_permutations(s)
  get_permutations(s).each { |p| puts p }
end

def get_permutations(s)
  case s.length
  when 0, 1
    [s]
  else
    last_char = s[-1]
    perms = []
    # Get all permutations of s[0..-2]
    sub_perms = get_permutations(s[0..-2])
    sub_perms.each do |sub_perm|
      (sub_perm.length + 1).times do |i|
        sub_perm_copy = sub_perm.dup
        perms << sub_perm_copy.insert(i, last_char)
      end
    end
    perms
  end
end