#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# 
# Copyright (c) 2009 TAKANO Mitsuhiro <tak at no32.tk>
#
# sig.rb: SkypeIrcGateway
# 建設予定地
#

require 'irc_client'
require 'skype_client'

class SkypeIrcGateway
	def initialize(config)
		@skype_chat = config[:skype_chat]
		@irc_chat = config[:irc_chat]
		@irc_name = config[:irc_name]
		@skype_client = SimpleSkypeClient.new(@skype_chat)
		@irc_client = SimpleIrcClient.new(@irc_chat, @irc_name)
		skype_initialize
		irc_initialize
	end
	
	def skype_initialize
		@skype_client.receive_message do |channel, name, message|
			@irc_client.send_message("#{name}: #{message}") unless channel == name
		end
		@skype_client.start
	end

	def irc_initialize
		@irc_client.receive_message do |channel, name, message|
			@skype_client.send_message("(swear) #{name}: #{message}") if channel == @skype_client
		end
		@irc_client.start
	end

	def start
		@skype_client.start
		@irc_client.start
	end

	def stop
		@skype_client.stop
		@irc_client.stop
	end	
end


if __FILE__ == $0 then
	config = {
		:skype_chat => '#akio0911/$yuiseki;1600dfa22ed008f5',
		:irc_chat => '#hackerscafe',
		:irc_name => 'skype_bot',
	}
	
	gw = SkypeIrcGateway.new(config)
	
	gw.start
	
	Signal.trap('INT') do
		gw.stop
		exit
	end
	
	loop do
		Thread.pass
		sleep 0.5
	end
end

