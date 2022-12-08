require 'pry'

file = File.open('input')
trees = []
file.readlines.each do |line|
  trees << line.chomp.chars.map(&:to_i) 
end

def print_map(map, width: 1)
  map.each do |row_ints|
    #puts row_ints.map{ |i| "%d" }.join('')
    row_ints.each do |i|
      printf("%-#{width}d", i)
    end
    puts
  end
  puts
end

X = trees[0].size
Y = trees.size

def empty_map(xsize,ysize)
  [].tap do |arr|
    ysize.times { arr << Array.new(xsize, 0) }
  end
end

def vis_from_left(vis_map, trees)
  for y in 1..Y-2
    tallest_so_far = trees[y][0]
    for x in 1..X-2
      if trees[y][x] > tallest_so_far
        vis_map[y][x] = 1
        tallest_so_far = trees[y][x]
        break if tallest_so_far == 9
      end
    end
  end
  vis_map
end

def vis_from_right(vis_map, trees)
  for y in 1..Y-2
    tallest_so_far = trees[y][trees[y].size-1]
    for x in (1..X-2).to_a.reverse
      if trees[y][x] > tallest_so_far
        vis_map[y][x] = 1
        tallest_so_far = trees[y][x]
        break if tallest_so_far == 9
      end
    end
  end
  vis_map
end

def vis_from_top(vis_map, trees)
  for x in 1..X-2
    tallest_so_far = trees[0][x]
    for y in 1..Y-2
      if trees[y][x] > tallest_so_far
        vis_map[y][x] = 1
        tallest_so_far = trees[y][x]
        break if tallest_so_far == 9
      end
    end
  end
  vis_map
end

def vis_from_bottom(vis_map, trees)
  for x in 1..X-2
    tallest_so_far = trees[trees[x].size-1][x]
    for y in (1..Y-2).to_a.reverse
      if trees[y][x] > tallest_so_far
        vis_map[y][x] = 1
        tallest_so_far = trees[y][x]
        break if tallest_so_far == 9
      end
    end
  end
  vis_map
end


left = vis_from_left(empty_map(X,Y), trees)
right = vis_from_right(empty_map(X,Y), trees)
top = vis_from_top(empty_map(X,Y), trees)
bottom = vis_from_bottom(empty_map(X,Y), trees)

vis = empty_map(X,Y)

for y in 0..Y-1
  for x in 0..X-1
    if y == 0 || x == 0 || y == Y-1 || x == X-1
      vis[y][x] = 1
    else
      vis[y][x] = left[y][x] | right[y][x] | top[y][x] | bottom[y][x]
    end
  end
end

def left_score(x_start, y_start, trees)
  this_tree = trees[y_start][x_start]
  score = 0
  tallest = 0
  for x in (0..x_start-1).to_a.reverse
    next_tree = trees[y_start][x]
    score += 1
    if next_tree >= this_tree
      break
    end
  end
  score
end

def right_score(x_start, y_start, trees)
  this_tree = trees[y_start][x_start]
  score = 0
  tallest = 0
  for x in x_start+1..X-1
    next_tree = trees[y_start][x]
    score += 1
    if next_tree >= this_tree
      break
    end
  end
  score
end

def up_score(x_start, y_start, trees)
  this_tree = trees[y_start][x_start]
  score = 0
  tallest = 0
  for y in (0..y_start-1).to_a.reverse
    next_tree = trees[y][x_start]
    score += 1
    if next_tree >= this_tree
      break
    end
  end
  score
end

def down_score(x_start, y_start, trees)
  this_tree = trees[y_start][x_start]
  score = 0
  for y in y_start+1..Y-1
    next_tree = trees[y][x_start]
    score += 1
    if next_tree >= this_tree
      break
    end
  end
  score
end

score = empty_map(X,Y)

for y in 0..Y-1
  for x in 0..X-1
    if y == 0 || x == 0 || y == Y-1 || x == X-1
      score[y][x] = 0
    else
      score[y][x] = left_score(x, y, trees) * right_score(x, y, trees) * up_score(x, y, trees) * down_score(x, y, trees)
    end
  end
end

#print_map(trees)
#print_map(vis)
#print_map(score, width: 5) # view with less -R

puts vis.flatten.sum
puts score.flatten.max

