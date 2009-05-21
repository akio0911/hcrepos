# -*- coding: utf-8 -*-
# テスト用

require 'socket'

s = TCPSocket.open("localhost", 3793)
s.write("1234567890")
s.write("1234567890")
puts s.read(5)

