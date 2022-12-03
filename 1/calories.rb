file = File.open('input')
input = file.readlines.map(&:chomp)

def totalize(arr)
  arr.reduce([0]) do |totals, elem|
    if elem.empty?
      totals << 0
    else
      totals << totals.pop + elem.to_i
    end
  end
end

puts "Part 1: #{totalize(input).max}"
puts "Part 2: #{totalize(input).max(3)}, sum: #{totalize(input).max(3).sum}"
