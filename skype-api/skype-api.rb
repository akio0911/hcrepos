require 'osx/cocoa'
OSX.require_framework 'Skype'
=begin
class Server < OSX::NSObject
  def onPlayerInfo(n)
    s = "#{n.userInfo['Name']} / #{n.userInfo['Artist']}"
    OSX::SkypeAPI.sendSkypeCommand("SET PROFILE MOOD_TEXT #{s}")
  end

  def clientApplicationName
    'NowPlayingOnSkype'
  end

  addRubyMethod_withType 'skypeAttachResponse:', 'v@:i'
  def skypeAttachResponse(status)
    return if status != 1

    center = OSX::NSDistributedNotificationCenter.defaultCenter
    center.addObserver_selector_name_object_(self,
                                             'onPlayerInfo:',
                                             'com.apple.iTunes.playerInfo',
                                             'com.apple.iTunes.player')
  end
end
=end

server = Server.alloc.init

OSX::SkypeAPI.setSkypeDelegate(server)
OSX::SkypeAPI.connect

OSX::NSRunLoop.currentRunLoop.run
