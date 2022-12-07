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
under100k = sizes.select { |name, size| size <= 100000 }
puts "Sum of dirs < 100k: #{under100k.map { |name, size| size }.sum}"
used = sizes['/']
puts "Space used: #{used}"
free = 70000000 - used
puts "Free space: #{free}"
required = 30000000
to_free = required - free
puts "Space to be freed up: #{to_free}"
big_enough = sizes.reject { |name, size| size < to_free }
puts "Dirs that reclaim enough space: #{big_enough}"
puts "Size of dir to delete: #{big_enough.map {|n,s| s }.min}"

