
def evaluate(cycle, x, signals)
  if (cycle + 20) % 40 == 0
    printf("%d, %d, %d\n", cycle, x, x * cycle)
    signals += x * cycle
  end
  [cycle += 1, signals]
end

file = File.open('input')
x = 1
cycle = 1
signals = 0
file.readlines.each do |line|
  case line
  when /noop/
    cycle, signals = evaluate(cycle, x, signals)
  when /addx (\-?\d+)/
    2.times { cycle, signals = evaluate(cycle, x, signals) }
    x += $1.to_i
  end
end
puts
puts signals

