
def evaluate(cycle, x)
  if (cycle % 40  - x).magnitude < 2
    print '#'
  else
    print '.'
  end
  if cycle % 40 == 0
    puts
  end
  cycle += 1
end

file = File.open('input')
x = 1
cycle = 0
file.readlines.each do |line|
  case line
  when /noop/
    cycle = evaluate(cycle, x)
  when /addx (\-?\d+)/
    2.times { cycle = evaluate(cycle, x) }
    x += $1.to_i
  end
end
puts
puts signals

