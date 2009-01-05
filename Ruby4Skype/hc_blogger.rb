require 'rubygems'
require 'time'
require 'uri'
require 'open-uri'
require 'rexml/document'
require 'feed-normalizer'
require 'skypeapi'

#rexml/documentでつくりなおすひつようあり

SkypeAPI.init
SkypeAPI.attachWait
id = "#voqn_skype/$6410ca0139e195d0"
uri = "http://hackerscafeblog.blogspot.com/feeds/posts/default"
feed = FeedNormalizer::FeedNormalizer.parse open(uri)
feed.entries.each do |entry|
  title = entry.title
  time = entry.last_updated
  url = entry.urls.first
  author = entry.authors.first
  how_ago = (Time.now - time)
  if true#how_ago.to_i < 60*5
    string = title + "\n" + author
    SkypeAPI::ChatMessage.create(id, string)
  end
end
