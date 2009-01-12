# coding: utf-8
require 'rubygems'
require 'rb-skypemac'
include SkypeMac

# 送信先
channel = '#akio0911/$yuiseki;1600dfa22ed008f5'
#sendto = "akio0911"
# 送信メッセージ
message = 'あざーっす'

# Skype.send_(:command => "CHATMESSAGE #{channel} #{message}")


Skype.send_(:command => "SEARCH RECENTCHATS").split(/,? /)[1..-1].each do |chat|
	puts chat
	# p Skype.send_(:command => "CHATMESSAGE #{chat} STATUS RECEIVED")
end


