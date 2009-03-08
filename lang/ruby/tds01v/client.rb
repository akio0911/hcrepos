require 'socket'

#if ARGV.size == 1
  s = TCPSocket.open("localhost", 12345)
  #s.puts("test")
#  s.send("AAA", 0)
  99999.times do |i|
    p 111
#    s.send("Z", 0)
    p 222
#    p s.recv(1)
    s.puts "HEY!!"
    p s.gets
    p 333
  end
  s.close
#end
