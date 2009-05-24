#!/usr/bin/env ruby
# -*- coding: utf-8 -*-


require "rubygems"
# gem "activeresource"
require "active_resource"
require "serialport"

class State < ActiveResource::Base
	self.site = 'http://cyberia.yuiseki.net/'
	def portd
		portd = 0
		portd |= 0b00000100 if power
		portd |= 0b00001000 if blue
		portd |= 0b00010000 if green
		portd |= 0b00100000 if yellow
		portd |= 0b01000000 if red
		return portd
	end
end

#5秒おきにRailsに問い合わせて出力する
loop {
	data = State.find(:last) # 最新データ
	puts data.inspect
	# puts data.object_id
	# puts data.class
	puts "\n"
	puts data.power # 勝手にメソッドができてる
	# puts data.blue
	# puts data.green
	# puts data.yellow
	# puts data.red
	puts sprintf('portd: %08b', data.portd)
	#data2 = Shop.find(:first) # 一番最初に投入された古いデータ
	sleep 5
}




