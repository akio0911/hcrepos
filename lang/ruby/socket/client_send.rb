require 'socket'

if ARGV.size == 1
  s = TCPSocket.open("localhost", 12345)
  #s.puts("test")
  s.send(ARGV[0], 0)
  s.close
end
