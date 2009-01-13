#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# 
# Copyright (c) 2009 TAKANO Mitsuhiro <tak at no32.tk>
#
# http://june29.jp/2008/04/23/ruby4skype/


require 'rubygems'
require 'skypeapi'

class SimpleSkypeClient
	def initialize(chat_id)
		SkypeAPI.init
		SkypeAPI.attachWait
		@chat = SkypeAPI::Chat.create(chat_id)
	end

	def create_message(msg)
		SkypeAPI::ChatMessage.create(@chat, msg)
	end

	def notify_message
		if block_given?
			SkypeAPI::ChatMessage.setNotify :Status, 'RECEIVED' do |msg|
				yield msg.getBody
			end
		end
	end

	def start
		@thread = Thread.start do
			until(@thread[:stop])
				SkypeAPI.polling
				sleep 0.123
			end
		end
	end

	def stop
		@thread[:stop] = true
		@thread.join
	end
end


if __FILE__ == $0 then
	chat = "#akio0911/$yuiseki;1600dfa22ed008f5"
	chat = "#voqn_skype/$6410ca0139e195d0"
	client = SimpleSkypeClient.new(chat)
	client.notify_message do |msg|
		puts msg
	end
	client.start
	Signal.trap(:TERM, 'DEFAULT') do
		client.stop
	end
end
