#!/usr/bin/env ruby
# http://d.hatena.ne.jp/curi1119/20080506/1210062892

require 'socket'
require 'kconv'

$KCODE = 'UTF8'

@server = "irc.freenode.net"
@port = 6666
@eol = "\r\n"
@nick = "skype_bot"
@channel = "#hackerscafe"

def send_cmd(cmd)
	p "Sending command..... :#{cmd}"
	@irc.write(cmd + @eol)
end

def login_and_join
	send_cmd("USER skype_bot, #{@server}, ignore, Hacker's Cafe")
	send_cmd("NICK #{@nick}")
	send_cmd("JOIN #{@channel}")
end

read = Thread.new do
	Thread.stop
	while msg = Kconv.toutf8(@irc.gets).split
		p msg.join(' ')
		send_cmd("PONG #{msg[1]}") if msg[0] == 'PING'
	end
end

write = Thread.new do
	Thread.stop
	while input = gets.chop
		send_cmd("PRIVMSG #{@channel} #{Kconv.tojis(input)}")
	end
end

@irc = TCPSocket.new(@server, @port)

read.run
login_and_join
write.run
read.join
write.join
