#最近のチャットすべてに、「あざーっす　Skypeチャット内部ID」と発言するサンプル
#実行すると顰蹙を買う！！

require 'rubygems'
require 'skypeapi'
SkypeAPI.init
SkypeAPI.attachWait
test = "#voqn_skype/$6410ca0139e195d0"
yuiseki = "#yuiseki/$97c57c5363208f6a"

chats = SkypeAPI::searchRecentChats
chats.each do |chat|
  unless chat.getTopic == ""
    string = "あざーっす " + chat.getName
    SkypeAPI::ChatMessage.create(chat.getName, string)
  end
end
