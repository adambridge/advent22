file = File.open('input')
path = []
sizes = Hash.new(0)
file.readlines.each do |line|
  case line
  when /cd \.\./
    path.pop
  when /cd (.*)/
    path << $1
  when /(\d+) .*/
    path.size.times { |i| sizes[path.first(i + 1).join('/')] += $1.to_i}
  end
end
sizes.select! { |name, size| size <= 100000 }
puts sizes.map { |name, size| size }.sum
