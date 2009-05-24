pat = [
  [0,1,1,1],
  [0,1,1,0],
  [1,0,1,1],
  [1,1,1,1],
]
0.upto(pat.size-1) do |y|
  0.upto(pat[0].size-1) do |x|
      pat[y][x] = pat[y][x] * 255
  end
end

scale = 4
x_max = (pat[0].size * scale) - 1
y_max = (pat.size * scale)- 1

0.upto(2) do |i|
  0.upto(y_max) do |y|
    0.upto(x_max) do |x|
      print sprintf "%4d", pat[y/scale][x/scale]
    end
    print "\n"
  end
end
print "\n"

0.upto(2) do |i|
  x_max.downto(0) do |x|
    0.upto(y_max) do |y|
      print sprintf "%4d", pat[y/scale][x/scale]
    end
    print "\n"
  end
end
print "\n"

0.upto(2) do |i|
  (y_max).downto(0) do |y|
    x_max.downto(0) do |x|
      print sprintf "%4d", pat[y/scale][x/scale]
    end
    print "\n"
  end
end
print "\n"

0.upto(2) do |i|
  0.upto(x_max) do |x|
    y_max.downto(0) do |y|
      print sprintf "%4d", pat[y/scale][x/scale]
    end
    print "\n"
  end
end
print "\n"
