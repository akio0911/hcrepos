# -*- coding: utf-8 -*-
require 'rubygems'
require 'iknow'
require 'oauth/consumer'
require 'pp'
require 'pit'

config = Pit.get("iknow.co.jp", :require => {
  "username" => "you email in iknow.co.jp",
  "password" => "your password in iknow.co.jp"
})

Iknow::Config.init do |conf|
  conf.api_host              = 'api.iknow.co.jp'
#  conf.api_key               = '' # 'SET_YOUR_API_KEY'
  conf.api_key               = 'ykh9t4zq5ewkxydznybkd7ux' # 'SET_YOUR_API_KEY'
  conf.oauth_consumer_key    = '' # 'SET_YOUR_OAUTH_CONSUMER_KEY'
  conf.oauth_consumer_secret = '' # 'SET_YOUR_OAUTH_CONSUMER_SECRET'
  conf.oauth_http_method     = :post
  conf.oauth_scheme          = :header
  conf.timeout               = 15
end

# Edit here
OAUTH_ACCESS_TOKEN = ''
OAUTH_ACCESS_TOKEN_SECRET = ''

# Edit here
IKNOW_USERNAME = config['username']
IKNOW_PASSWORD = config['password']

please_get_api_key =<<EOS
This example needs your own iKnow! API key.
(for only Iknow::Item.extract example)

You can get iKnow! API key at iKnow! Developers.
iKnow! Developers (http://developer.iknow.co.jp/)

Thanks!
EOS

if Iknow::Config.api_key == ''
  raise ArgumentError.new(please_get_api_key)
end


###########################
## WITHOUT AUTHORIZATION ##
###########################

=begin
puts "WITHOUT AUTHORIZATION"
## User API
puts "# User API Calls"
@user = Iknow::User.find('akio0911') # Iknow::User # ユーザー情報を取得
@user.items(:include_sentences => true) # Array of Iknow::Item 学習済みのセンテンスを取得
@user.lists.first.class # Iknow::List # 学習済みのコースのリストを取得できる
@user.friends.first.class # Iknow::User フレンド一覧を取得
@user.study.results # Iknow::User::Study::Result 学習結果を取得
@user.study.total_summary # Iknow::User::Study::TotalSummary 学習結果を取得
@matched_users = Iknow::User.matching('matake') # Iknow::User ユーザー情報を検索
=end

=begin
## List API
puts "# List API Calls"
@recent_lists = Iknow::List.recent # ???
@list = Iknow::List.find(31509, :include_sentences => true, :include_items => true) #  Iknow::List
@list.items # Iknow::Item
@list.sentences # Iknow::Sentence
@matched_lists = Iknow::List.matching("イタリア語であいさつ") # Iknow::List
=end

=begin
## Item API
puts "# Item API Calls"
@recent_items = Iknow::Item.recent(:include_sentences => true) # Iknow::Item
@item = Iknow::Item.find(437525) # Iknow::Item
@matched_items = Iknow::Item.matching('record', :include_sentences => true) # Iknow::Item
@items = Iknow::Item.extract("sometimes, often, electrical") # Iknow::Item
@items.first.sentences
=end

=begin
## Sentence API
puts "# Sentence API Calls"
@recent_sentences = Iknow::Sentence.recent # Iknow::Sentence
@sentence = Iknow::Sentence.find(312271) # Iknow::Sentence
@matched_sentences = Iknow::Sentence.matching('record') # Iknow::Sentence
=end


########################
## WITH AUTHORIZATION ##
########################

iknow_auth = case
  when !OAUTH_ACCESS_TOKEN.empty?
    if Iknow::Config.oauth_consumer_key.empty? or Iknow::Config.oauth_consumer_secret.empty?
      raise ArgumentError.new("oauth_consumer_key and oauth_consumer_secret are required")
    end
    Iknow::Auth.new(:token => OAUTH_ACCESS_TOKEN, :secret => OAUTH_ACCESS_TOKEN_SECRET)
  when IKNOW_USERNAME != ''
    Iknow::Auth.new(:username => IKNOW_USERNAME, :password => IKNOW_PASSWORD)
  else
    nil
  end
unless iknow_auth
  puts "Skip calls which require authentication"
  exit
else
  puts "## WITH AUTHORIZATION :: #{iknow_auth.mode}"
end

## List API
puts "# List API"
@list = Iknow::List.create(iknow_auth, :title => 'iKnow! gem test', :description => 'A list for iKnow! gem test')
pp @list
pp @list.class
exit
@list.add_item(iknow_auth, Iknow::Item.find(437525))
@list.delete_item(iknow_auth, @list.items.first)
@list.delete(iknow_auth)

## Item API
puts "# Item API"
@item = Iknow::Item.create(iknow_auth, :cue => {:text => 'hello world! 2', :language => 'en', :part_of_speech => 'E'},
                                       :response => {:text => 'ハローワールド！', :language => 'ja'})
@item.add_image(iknow_auth, 'http://farm4.static.flickr.com/3276/3102381796_a33c1ffdf1.jpg')
@item.add_sound(iknow_auth, 'http://matake.jp/download/hello_world.mp3')
@item.add_tags(iknow_auth, 'sample', 'programming')

## Sentence API
puts "# Sentence API"
@sentence = Iknow::Sentence.create(iknow_auth, :text => 'Hello World!', :item => Iknow::Item.matching('hello world').first)
@sentence.add_image(iknow_auth, 'http://farm4.static.flickr.com/3276/3102381796_a33c1ffdf1.jpg')
@sentence.add_sound(iknow_auth, 'http://matake.jp/download/hello_world.mp3')
