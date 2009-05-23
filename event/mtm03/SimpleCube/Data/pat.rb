pat = [
  [0,0,1,0],
  [0,0,1,1],
  [0,0,0,0],
  [0,0,0,0],
]
0.upto(pat.size-1) do |y|
  0.upto(pat[0].size-1) do |x|
      pat[y][x] = pat[y][x] * 255
  end
end

0.upto(2) do |i|
  0.upto(15) do |y|
    0.upto(15) do |x|
      print sprintf "%4d", pat[y/4][x/4]
    end
    print "\n"
  end
end
print "\n"

0.upto(2) do |i|
  15.downto(0) do |x|
    0.upto(15) do |y|
      print sprintf "%4d", pat[y/4][x/4]
    end
    print "\n"
  end
end
print "\n"

0.upto(2) do |i|
  15.downto(0) do |y|
    15.downto(0) do |x|
      print sprintf "%4d", pat[y/4][x/4]
    end
    print "\n"
  end
end
print "\n"

0.upto(2) do |i|
  0.upto(15) do |x|
    15.downto(0) do |y|
      print sprintf "%4d", pat[y/4][x/4]
    end
    print "\n"
  end
end
print "\n"
