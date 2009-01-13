#!/usr/bin/env ruby
# http://d.hatena.ne.jp/curi1119/20080506/1210062892
# 
# Copyright (c) 2009 TAKANO Mitsuhiro <tak at no32.tk>
#

require 'socket'
require 'kconv'

$KCODE = 'UTF8'

class SimpleIrcClient
	def initialize(channel, nick)
		@server = "irc.freenode.net"
		@port = 6667
		@irc = TCPSocket.new(@server, @port)
		@eol = "\r\n"
		@channel = channel
		@nick = nick
	end
	
	def send_cmd(cmd)
		p "Sending command..... :#{cmd}" if $DEBUG
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
					channel = msg[2]
					/^:([^!]*)!/ =~ msg[0]
					nick = $1
					message = msg[3..-1].join(' ')[1..-1]
					@block.call(channel, nick, message)
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
	channel = '#hackerscafe'
	nick = 'skype_bot'
	client = SimpleIrcClient.new(channel, nick)
	client.receive_message do |channel, nickname, message|
		puts("#{channel}, #{nickname}, #{message}") unless channel == nick
	end
	client.start
	client.send_message('hello')
	client.stop
end

