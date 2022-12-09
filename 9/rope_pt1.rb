def update_tail(hx,hy,tx,ty)
  return [tx,ty] if adjacent?(hx,hy,tx,ty)
  tx += 1 if hx > tx
  tx -= 1 if hx < tx
  ty += 1 if hy > ty
  ty -= 1 if hy < ty
  return [tx,ty]
end

def adjacent?(hx,hy,tx,ty)
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
hx = 0
hy = 0
tx = 0
ty = 0
visited = Hash.new(false)

file.readlines.each do |line|
  case line
  when /R (\d+)/
    $1.to_i.times do
      hx += 1
      tx,ty = update_tail(hx,hy,tx,ty)
      record_tail(tx,ty,visited)
    end
  when /L (\d+)/
    $1.to_i.times do
      hx -= 1
      tx,ty = update_tail(hx,hy,tx,ty)
      record_tail(tx,ty,visited)
    end
  when /U (\d+)/
    $1.to_i.times do
      hy += 1
      tx,ty = update_tail(hx,hy,tx,ty)
      record_tail(tx,ty,visited)
    end
  when /D (\d+)/
    $1.to_i.times do
      hy -= 1
      tx,ty = update_tail(hx,hy,tx,ty)
      record_tail(tx,ty,visited)
    end
  end
end

puts visited.size
