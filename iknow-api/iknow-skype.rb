require "rexml/document"
require "open-uri"
require 'skypeapi'


iknow_haikyo = "#akio0911/$690dcecf64d10fd6"
iknow_test = "#akio0911/$b7811b933d2d6baa"
iknow_production = "#akio0911/$946e5362fcf58bb5"
iknow_hc = "#akio0911/$yuiseki;1600dfa22ed008f5"
iknow_iphone = "#akio0911/$rdang8174;91b224d3e7ab59ea"
#iknow_kbmj = "#akio0911/$araki888_888;48150917528a2b3e"

URL_BASE = 'http://api.iknow.co.jp/sentences/matching/'
URL = 'http://api.iknow.co.jp/sentences/matching/business.rss'
ICON = '(wait)'

SkypeAPI.init
SkypeAPI.attachWait

def post_error(chat_name, s)
 SkypeAPI::ChatMessage.create(chat_name , ";( error... : #{s}")
end

def make_url(keyword)
  return URL_BASE + "#{keyword}.rss?per_page=1"
end

def chatlog(chatmessage)
  chatname = chatmessage.getChat.getName
  msg = chatmessage.getBody
  user = chatmessage.getFrom
  puts "chatname #{chatname}"
  puts "msg  #{msg}"
  puts "user #{user}"
end

def get_sentence(keyword, chat_name)
  p 'get_sentence'
#  SkypeAPI::ChatMessage.create(chat_name , "#{ICON} I'm seaching about #{keyword} ....")
  xml = open(make_url(keyword)).read
  p 'after open'
  doc = REXML::Document.new xml
  SkypeAPI::ChatMessage.create(chat_name , "#{ICON} I don't know #{keyword}....") unless doc.elements['/rss/channel/item']
  doc.elements.each('/rss/channel/item') do |entry|
    title = entry.elements["title"].text
    description = entry.elements["description"].to_s
    link = entry.elements["link"].text
    if description =~ /\[CDATA\[(.*)\]\]/
      japanese = $1
    end
    s = "#{title} #{japanese} #{link}"
    SkypeAPI::ChatMessage.create(chat_name , "#{ICON} " + s)
  end
end

SkypeAPI::ChatMessage.setNotify :Status, 'RECEIVED' do |chatmessage|
  begin
puts "RECEIVED"
    chat_name = chatmessage.getChat.getName
puts chat_name
    if chat_name == iknow_test or chat_name == iknow_production or chat_name == iknow_hc or chat_name == iknow_iphone # or chat_name == iknow_kbmj
      puts 'RECEIVED'
      p chatmessage
      puts "chatmessage.getBody = #{chatmessage.getBody}"
      if chatmessage.getBody == 'give me english'
        SkypeAPI::ChatMessage.create(chat_name , get_sentence('business'))
      elsif chatmessage.getBody =~ /i want to know about (.*)/ or chatmessage.getBody =~ /iknow (.*)/ or chatmessage.getBody =~ /iKnow (.*)/
p 'OK'
         keyword = $1
         SkypeAPI::ChatMessage.create(chat_name , "#{ICON} I don't know #{keyword}....") unless keyword
        get_sentence(keyword, chat_name)
      end
    end
  rescue => exc
    post_error(chatmessage.getChat.getName, exc.inspect)
    puts exc.inspect
  end
end

SkypeAPI::ChatMessage.setNotify :Status, 'SENT' do |chatmessage|
  begin
    chat_name = chatmessage.getChat.getName
    if chat_name == iknow_test or chat_name == iknow_production
      puts 'SENT'
      p chatmessage
      chatlog(chatmessage)
    end
  rescue => exc
    post_error(chatmessage.getChat.getName, exc.inspect)
    puts exc.inspect
  end
end

p 'start loop'

loop do
  SkypeAPI.polling
#  sleep 0.123
  sleep 1.0/10.0
end
