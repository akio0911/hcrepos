#!/usr/bin/env ruby
# -*- coding: utf-8 -*-


require "rubygems"
# gem "activeresource"
require "active_resource"
require "serialport"

class State < ActiveResource::Base
	self.site = 'http://cyberia.yuiseki.net/'
	self.timeout = 5
	def portd
		portd = 0
		portd |= 0b00000100 if power
		portd |= 0b00001000 if red
		portd |= 0b00010000 if blue
		portd |= 0b00100000 if green
		portd |= 0b01000000 if yellow
		return portd
	end
end

port = "/dev/tty.usbserial-A9007L8W"
serial = SerialPort.new(port, 9600, 8, 1, SerialPort::NONE)

def finish(serial)
	serial.putc 0b00000000
	serial.close
end

Signal.trap(:INT) do
	finish(serial)
end

prev_portd = nil
#5秒おきにRailsに問い合わせて出力する
loop {
	begin
		data = State.find(:last) # 最新データ
	rescue ActiveResource::TimeoutError
		redo
	end
	puts data.inspect
	# puts data.object_id
	# puts data.class
	# puts "\n"
	# puts data.power # 勝手にメソッドができてる
	# puts data.blue
	# puts data.green
	# puts data.yellow
	# puts data.red
	break if serial.closed?
	if prev_portd != data.portd then
		serial.putc data.portd
		prev_portd = data.portd
		puts sprintf('portd: %08b', data.portd)
	end
	#data2 = Shop.find(:first) # 一番最初に投入された古いデータ
	sleep 3
}




