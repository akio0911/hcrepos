# -*- coding: utf-8 -*-
# http://twitter.com/hirameki の発言を Skype API に流してブレストに使いたい
# まだ作りかけ

require 'osx/cocoa'
OSX.require_framework 'Skype'

class Server < OSX::NSObject
  def onPlayerInfo(n)
#    s = "#{n.userInfo['Name']} / #{n.userInfo['Artist']}"
    s = 'XXXXXXXXXXXXXXX'
    OSX::SkypeAPI.sendSkypeCommand("SET PROFILE MOOD_TEXT #{s}")
  end

  def clientApplicationName
    'skype-hirameki.rb'
  end

  addRubyMethod_withType 'skypeAttachResponse:', 'v@:i'
  def skypeAttachResponse(status)
    return if status != 1

    center = OSX::NSDistributedNotificationCenter.defaultCenter
    center.addObserver_selector_name_object_(self,
                                             'onPlayerInfo:',
                                             'com.apple.iTunes.playerInfo',
                                             'com.apple.iTunes.player')
    OSX::SkypeAPI.sendSkypeCommand("CHATMESSAGE #voqn_skype/$6410ca0139e195d0 TEST")
  end
end

server = Server.alloc.init

OSX::SkypeAPI.setSkypeDelegate(server)
OSX::SkypeAPI.connect

OSX::NSRunLoop.currentRunLoop.run
