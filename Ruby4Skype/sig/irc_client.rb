#!/usr/bin/env ruby
# http://d.hatena.ne.jp/curi1119/20080506/1210062892
# 
# Copyright (c) 2009 TAKANO Mitsuhiro <tak at no32.tk>
#

require 'socket'
require 'kconv'

$KCODE = 'UTF8'

class SimpleIrcClient
	def initialize
		@server = "irc.freenode.net"
		@port = 6667
		@irc = TCPSocket.new(@server, @port)
		@eol = "\r\n"
		@nick = "skype_bot"
		@channel = "#hackerscafe"
	end
	
	def send_cmd(cmd)
		p "Sending command..... :#{cmd}"
		@irc.write(cmd + @eol)
	end

	def send_message(input)
		send_cmd("PRIVMSG #{@channel} #{Kconv.tojis(input)}")
	end

	def receive_message(&block)
		raise unless block_given?
		@block = block
	end

	def login_and_join
		send_cmd("USER skype_bot, #{@server}, ignore, Hacker's Cafe")
		send_cmd("NICK #{@nick}")
		send_cmd("JOIN #{@channel}")
	end

	def start
		@read_thread = read_thread = Thread.start do
			while msg = Kconv.toutf8(@irc.gets).split
				p msg.join(' ') if $DEBUG
				send_cmd("PONG #{msg[1]}") if msg[0] == 'PING'
				if msg[1] == 'PRIVMSG' then
					raise unless @block
					#:takano32!n=takano32@x.ne.jp PRIVMSG #hackerscafe :testtest
					p channel = msg[2]
					p nickname = /^:([^!]*)!/
					p message = msg[3][1..-1]
				end

			end
		end
		login_and_join
	end

	def stop
		@read_thread.join
	end
end


if __FILE__ == $0 then
	client = SimpleIrcClient.new
	client.start
	client.send_message('こんにちは')
	client.stop
end

