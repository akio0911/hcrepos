#5分おきに実行される本体
#柔軟なロードパス(windowsのcronがクソなため)
$: << File.dirname(__FILE__)
require "hc_blog"
#ここにrequire "Sample"などとして追加
require 'rubygems'
gem 'mechanize', '= 0.7.8'
require 'mechanize'
require 'cgi'
require 'kconv'
require 'time'
require 'skypeapi'
require 'open-uri'
require 'rexml/document'

SkypeAPI.init
SkypeAPI.attachWait

test = "#voqn_skype/$6410ca0139e195d0"
yuiseki = "#yuiseki/$97c57c5363208f6a"
hack = "#akio0911/$yuiseki;1600dfa22ed008f5"

def post_test(chatid, logs)
  log = logs[0]
  SkypeAPI::ChatMessage.create(chatid, "test " + log[:text])
end

post_test(hack, HackersCafeBlog.feeds_logs)
exit
