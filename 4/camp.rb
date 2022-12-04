file = File.open('input')
lines = file.readlines.map(&:chomp)

full_overlaps = lines.map do |line|
  x1, x2, y1, y2 = line.split(/[,-]/).map(&:to_i)
  if x1 >= y1 && x2 <= y2 || y1 >= x1 && y2 <= x2
    1
  else
    0
  end
end

all_overlaps = lines.map do |line|
  x1, x2, y1, y2 = line.split(/[,-]/).map(&:to_i)
  if x1 >= y1 && x1 <= y2 || x2 >= y1 && x2 <= y2
    1 # partial overlap
  elsif x1 >= y1 && x2 <= y2 || y1 >= x1 && y2 <= x2
    1 # full overlap
  else
    0
  end
end

for i in 0..lines.size-1 do
  puts "#{i} #{lines[i]}: #{all_overlaps[i]}"
end

puts full_overlaps.sum
puts all_overlaps.sum

