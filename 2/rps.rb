file = File.open('input')
pairs = file.readlines.map do |line|
  [line[0], line[2]]
end

outcomes = {
  'A' => {
    'X' => 3,
    'Y' => 6,
    'Z' => 0
  },
  'B' => {
    'X' => 0,
    'Y' => 3,
    'Z' => 6
  },
  'C' => {
    'X' => 6,
    'Y' => 0,
    'Z' => 3
  }
}

shapes = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

outcomes2 = {
  'X' => 0,
  'Y' => 3,
  'Z' => 6
}

shapes2 = {
  'A' => {
    'X' => 3,
    'Y' => 1,
    'Z' => 2
  },
  'B' => {
    'X' => 1,
    'Y' => 2,
    'Z' => 3
  },
  'C' => {
    'X' => 2,
    'Y' => 3,
    'Z' => 1
  }
}

scores = pairs.map do |pair|
  outcomes[pair[0]][pair[1]] + shapes[pair[1]]
end

scores2 = pairs.map do |pair|
  shapes2[pair[0]][pair[1]] + outcomes2[pair[1]]
end

puts scores.sum
puts scores2.sum


