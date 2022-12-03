file = File.open('input')
lines = file.readlines.map(&:chomp)

def priority(c)
  if c.ord > 96 # uppercase
    c.ord - 96
  else
    c.ord - 38
  end
end

values = lines.map do |line|
  mid = line.size / 2
  a = line[..mid-1]
  b = line[mid..]
  intersection = a.chars & b.chars
  priority(intersection[0])
end

puts values.sum

triplets = []
while lines.size > 0
  triplets << lines.pop(3)
end

values2 = triplets.map do |t|
  intersection = t[0].chars & t[1].chars & t[2].chars
  priority(intersection[0])
end
  
puts values2.sum
