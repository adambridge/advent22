def read_stacks(lines)
  # Find the bottom of the stacks diagram
  base = 0
  while lines[base] !~ /^ 1 [ 0-9]*$/
    base += 1
  end
  number_of_stacks = (lines[base].size + 1) / 4
  stacks = [] 
  number_of_stacks.times { stacks << [] }

  # Read the stacks into an array of arrays, from the bottom row up
  row = base - 1
  while row >= 0
    stack = 0
    while stack < number_of_stacks
      col = 4 * stack + 1
      if col < lines[row].size
        char = lines[row].chars[col]
        stacks[stack] << char if char != ' '
        stack += 1
      else next
      end
    end
    row -= 1
  end
  stacks
end

def rearrange1(stacks, lines)
  lines.each do |line|
    if line =~ /move (\d+) from (\d+) to (\d+)/
      quantity = $1.to_i
      from = $2.to_i - 1
      to = $3.to_i - 1
      quantity.times do
        stacks[to].push(stacks[from].pop)
      end
    end
  end
end

def rearrange2(stacks, lines)
  lines.each do |line|
    if line =~ /move (\d+) from (\d+) to (\d+)/
      quantity = $1.to_i
      from = $2.to_i - 1
      to = $3.to_i - 1
      stacks[to] += stacks[from].pop(quantity)
    end
  end
end

def print_tops(stacks)
  stacks.each do |stack|
    putc stack.last
  end
  puts
end

file = File.open('input')
lines = file.readlines.map(&:chomp)

stacks = read_stacks(lines)
print_tops(stacks)

stacks1 = stacks.map(&:dup)
rearrange1(stacks1, lines)
print_tops(stacks1)

stacks2 = stacks.map(&:dup)
rearrange2(stacks2, lines)
print_tops(stacks2)

