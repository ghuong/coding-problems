# CtCI 4.7

# Given list of projects, and dependencies 
# (list of pairs of projects where second project is dependent on first)
# where all of a project's dependencies must be built before the project is,
# Find a build-order allowing all projects to be built, or return false
def build_order(projects, dependencies)
  num_dependencies = Hash.new(0)
  dependents = Hash.new {|h, k| h[k] = []}

  # Build dependency graph (using hashes)
  dependencies.each do |dependency|
    num_dependencies[dependency[1]] += 1
    dependents[dependency[0]] << dependency[1]
  end

  buildables = [] # queue of projects whose dependencies are built
  order = [] # projects built

  # Enqueue all buildable projects
  projects.each do |project|
    buildables << project if num_dependencies[project] == 0
  end

  # Build the buildable projects, enqueue projects that become opened up
  until buildables.empty?
    buildable = buildables.shift
    order << buildable
    dependents[buildable].each do |dependent|
      num_dependencies[dependent] -= 1
      buildables << dependent if num_dependencies[dependent] == 0
    end
  end

  if order.length == projects.length
    return order
  else
    return false
  end
end

def test
  test_1 &&
  test_2
end

def test_1
  projects = ["a", "b", "c", "d", "e", "f", "g"]
  dependencies = [
    ["f", "c"],
    ["f", "a"],
    ["c", "a"],
    ["f", "b"],
    ["b", "a"],
    ["b", "e"],
    ["a", "e"],
    ["d", "g"]
  ]
  expected = ["d", "f", "g", "c", "b", "a", "e"]
  actual = build_order(projects, dependencies)
  expected == actual
end

def test_2
  projects = ["a", "b", "c", "d", "e", "f", "g"]
  dependencies = [
    ["f", "c"],
    ["f", "a"],
    ["c", "a"],
    ["f", "b"],
    ["b", "a"],
    ["b", "e"],
    ["a", "e"],
    ["d", "g"],
    ["e", "c"]
  ]
  expected = false
  actual = build_order(projects, dependencies)
  expected == actual
end