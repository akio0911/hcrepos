# -*- coding: utf-8 -*-
require 'socket'
require 'thread'
require 'tds01v'

if ARGV.size != 1
  puts "デバイスのパスを指定して下さい。"
  exit
end

gs = TCPServer.open(12345)
addr = gs.addr # ["AF_INET6", 12345, "0.0.0.0", "0.0.0.0"]
addr.shift
p addr # [12345, "0.0.0.0", "0.0.0.0"]
printf("server is on %s\n", addr.join(":"))

device = ARGV[0]
t = Tds01v.new(device)

while true
  # gs.accept は接続要求を待ち受ける
  # 接続要求がくると新しいソケットが作成され、
  # そのままスレッドの引数として渡される
  Thread.start(gs.accept) do |s| 
    print(s, "is accepted\n")
#    puts(s.gets)
#    p s.recv(3)
#    s.puts "BYE"

    while true
      p s.recv(4)

      direction = t.get_direction

      puts "direction : #{direction}"
      #    p direction.to_s
      #    s.puts direction.to_s
      d = sprintf("%04d", direction)
      p d
      s.send(d, 0)
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
    print(s, " is gone\n")
    s.close
  end
end
