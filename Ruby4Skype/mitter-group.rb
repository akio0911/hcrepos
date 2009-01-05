require 'rubygems'
gem 'mechanize', '= 0.7.8'
require 'mechanize'
require 'cgi'
require 'kconv'
require 'time'
require 'skypeapi'
SkypeAPI.init
SkypeAPI.attachWait
test = "#voqn_skype/$6410ca0139e195d0"
yuiseki = "#yuiseki/$97c57c5363208f6a"
hack = "#akio0911/$yuiseki;1600dfa22ed008f5"

agent = WWW::Mechanize.new
agent.max_history = 1

  page = agent.get('http://mitter.jp/groups/25/posts')
  page.body = page.body.toutf8
  videos=[]
  page.search('div.video').each do |log|
    title = log.search('div.video-info').search('a').first.get_attribute(:title)
    url = log.search('span.service').search('a').first.get_attribute(:href)
    name = log.search('div.date').search('a').first.inner_text
    time_row = log.search('div.date').search('span').first.get_attribute(:title)
    time = Time.parse(time_row)+(60*60*9)
    videos.push({:title => title.chomp, :url => url.chomp, :time => time, :user => name})
  end
  videos.each do |video|
    how_ago = (Time.now - video[:time])
    #puts how_ago.to_i.to_s + " " + video[:time].to_s
    if how_ago.to_i <= 60*6
      string = video[:user] + " によって、Hacker'sCafeグループに動画が投稿されました:\n" + video[:title] + " " + video[:url]
      SkypeAPI::ChatMessage.create(hack, string)
    end
  end
