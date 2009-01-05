#5分おきに実行
require 'rubygems'
gem 'mechanize', '= 0.7.8'
require 'mechanize'
require 'cgi'
require 'kconv'
require 'time'
require 'skypeapi'
require 'open-uri'
require 'rexml/document'

require 'mitter'
require 'github'

SkypeAPI.init
SkypeAPI.attachWait
test = "#voqn_skype/$6410ca0139e195d0"
yuiseki = "#yuiseki/$97c57c5363208f6a"
hack = "#akio0911/$yuiseki;1600dfa22ed008f5"

def post_chat(chatid, logs)
  logs.each do |log|
    how_ago = (Time.now - log[:time])
    if how_ago.to_i <= 60*6
      SkypeAPI::ChatMessage.create(chatid, log[:text])
    end
  end
end

logs = Mitter.logs_of_users
post_chat(test, logs)

logs = Mitter.logs_of_groups
post_chat(hack, logs)

logs = Github.commit_logs
post_chat(hack, logs)
