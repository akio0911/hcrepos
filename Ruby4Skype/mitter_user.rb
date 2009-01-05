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

USERS = ["yuiseki", "skashu", "llcheesell", "retlet", "vaac", "delphie", "urabi_sama", "yusukezzz", "jazzanova", "otsune"]
USERS.each do |user|
  url = "http://mitter.jp/" + user
  page = agent.get(url)
  page.body = page.body.toutf8
  videos=[]
  page.search('div.log-details').each do |log|
    title = log.search('h3.title').search('a').first.inner_text
    url = log.search('span.service').search('a').first.get_attribute(:href)
    time_row = log.search('span.watched-at').first.get_attribute(:title)
    time = Time.parse(time_row)+(60*60*9)
    videos.push({:title => title.chomp, :url => url.chomp, :time => time})
  end
  videos.each do |video|
    how_ago = (Time.now - video[:time])
    if how_ago.to_i <= 60*6
      string = user + "がまた動画Mitter: " + video[:title] + " " + video[:url]
      SkypeAPI::ChatMessage.create(test, string)
    end
  end
end
