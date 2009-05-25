# -*- coding: utf-8 -*-
require 'socket'

s = TCPSocket.open("localhost", 12345)
while true
  s.send("ZZZZ", 0)
  d = s.recv(4).to_i
  p d
  if d < 45*10 then
    puts "北"
  elsif d < (90+45)*10
    puts "東"
  elsif d < (90*2+45)*10
    puts "南"
  elsif d < (90*3+45)*10
    puts "西"
  else
    puts "北"
  end
end
s.close
