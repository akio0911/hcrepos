require 'socket'

s = TCPSocket.open("localhost", 12345)
#s.puts("test")
#s.send("ABC", 0)
s.puts "HELLO"
p s.gets
s.close

