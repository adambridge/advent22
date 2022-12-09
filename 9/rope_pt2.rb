def update_tail(hx,hy,tx,ty)
  return [tx,ty] if adjacent?(hx,hy,tx,ty)
  tx += 1 if hx > tx
  tx -= 1 if hx < tx
  ty += 1 if hy > ty
  ty -= 1 if hy < ty
  return [tx,ty]
end

def adjacent?(hx,hy,tx,ty)
  #puts "h:(#{hx},#{hy}), t:(#{tx},#{ty})"
  if (hx - tx).magnitude <= 1 && (hy - ty).magnitude <= 1
    true
  else
    false
  end
end

def record_tail(tx,ty,visited)
  visited[[tx,ty]] = true
end

file = File.open('input')
x = Array.new(10, 0)
y = Array.new(10, 0)
visited = Hash.new(false)

file.readlines.each do |line|
  case line
  when /R (\d+)/
    $1.to_i.times do
      x[0] += 1
      for i in 1..9
        x[i],y[i] = update_tail(x[i-1],y[i-1],x[i],y[i])
      end
      record_tail(x[9],y[9],visited)
    end
  when /L (\d+)/
    $1.to_i.times do
      x[0] -= 1
      for i in 1..9
        x[i],y[i] = update_tail(x[i-1],y[i-1],x[i],y[i])
      end
      record_tail(x[9],y[9],visited)
    end
  when /U (\d+)/
    $1.to_i.times do
      y[0] += 1
      for i in 1..9
        x[i],y[i] = update_tail(x[i-1],y[i-1],x[i],y[i])
      end
      record_tail(x[9],y[9],visited)
    end
  when /D (\d+)/
    $1.to_i.times do
      y[0] -= 1
      for i in 1..9
        x[i],y[i] = update_tail(x[i-1],y[i-1],x[i],y[i])
      end
      record_tail(x[9],y[9],visited)
    end
  end
end

puts visited.size
