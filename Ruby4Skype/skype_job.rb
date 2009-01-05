require 'rubygems'
gem 'mechanize', '= 0.7.8'
require 'mechanize'
require 'cgi'
require 'kconv'
require 'time'
require 'skypeapi'
require 'uri'
require 'open-uri'
require 'rexml/document'

require 'mitter'
require 'hc_blogger'

SkypeAPI.init
SkypeAPI.attachWait
test = "#voqn_skype/$6410ca0139e195d0"
yuiseki = "#yuiseki/$97c57c5363208f6a"
hack = "#akio0911/$yuiseki;1600dfa22ed008f5"

videos = Mitter.logs_of_groups
videos.each do |video|
  how_ago = (Time.now - video[:time])
  if how_ago.to_i <= 60*6
    string = video[:user] + " によって、Hacker'sCafeグループに動画が投稿されました:\n" + video[:title] + " " + video[:url]
    SkypeAPI::ChatMessage.create(hack, string)
  end
end

videos = Mitter.logs_of_users
videos.each do |video|
  how_ago = (Time.now - video[:time])
  if how_ago.to_i <= 60*6
    string = video[:user] + "がまた動画Mitter: " + video[:title] + " " + video[:url]
    SkypeAPI::ChatMessage.create(test, string)
  end
end

