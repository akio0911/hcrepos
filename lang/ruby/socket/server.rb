# -*- coding: utf-8 -*-
require 'socket'
require 'thread'

gs = TCPServer.open(12345)
addr = gs.addr # ["AF_INET6", 12345, "0.0.0.0", "0.0.0.0"]
addr.shift
p addr # [12345, "0.0.0.0", "0.0.0.0"]
printf("server is on %s\n", addr.join(":"))

while true
  # gs.accept は接続要求を待ち受ける
  # 接続要求がくると新しいソケットが作成され、
  # そのままスレッドの引数として渡される
  Thread.start(gs.accept) do |s|
    print(s, "is accepted\n")
    puts(s.gets)
#    p s.recv(3)
    s.puts "BYE"
    print(s, " is gone\n")
    s.close
  end
end
