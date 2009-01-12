#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# 
# Copyright (c) 2009 TAKANO Mitsuhiro <tak at no32.tk>
#
# http://june29.jp/2008/04/23/ruby4skype/


require 'rubygems'
require 'skypeapi'

SkypeAPI.init
SkypeAPI.attachWait

chat = SkypeAPI::Chat.create(user)
SkypeAPI::ChatMessage.create(chat, "Hello, World!")

SkypeAPI::ChatMessage.setNotify :Status, 'RECEIVED' do |chatmessage|
  SkypeAPI::ChatMessage.create(chat, chatmessage.getBody)
end

loop do
  SkypeAPI.polling
  sleep 0.123
end
