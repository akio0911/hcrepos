# -*- coding: utf-8 -*-
# テスト用

require 'socket'

port = 3793
gs = TCPServer.open(port)

loop do
  Thread.start(gs.accept) do |s|
    puts "Now accepting connections on address port #{port}"
    puts s.read(10)
    puts "---"
    puts s.read(10)
    puts "---END"
    s.write(">> OK")
    s.close
  end
end

