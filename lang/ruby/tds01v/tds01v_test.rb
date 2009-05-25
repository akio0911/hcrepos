# -*- coding: utf-8 -*-
require 'tds01v'

if ARGV.size != 1
  puts "デバイスのパスを指定して下さい。"
  exit
end

device = ARGV[0]
t = Tds01v.new(device)
while true
  direction = t.get_direction

  puts "direction : #{direction}"
  if direction < 45*10 then
    puts "北"
  elsif direction < (90+45)*10
    puts "東"
  elsif direction < (90*2+45)*10
    puts "南"
  elsif direction < (90*3+45)*10
    puts "西"
  else
    puts "北"
  end
end
