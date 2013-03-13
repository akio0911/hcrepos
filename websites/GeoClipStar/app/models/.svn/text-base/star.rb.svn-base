# -*- coding: utf-8 -*-
#require 'rss'
require 'open-uri'
require 'rexml/document'
require 'rexml-expansion-fix'


class Star < ActiveRecord::Base
  # ジオクリのコンテンツ検索APIを叩いてDBにインポート
  # cron で 'ruby script/runner 'Star.import_feeds'' などとして呼ぶ
  def self.import_feeds
#    Star.delete_all

    url_base = 'http://api.geoclip.jp/api/feed.php'

    # 各自書き足して!!
#     member_ids = [
#       [936, 'ksasao'],
#       [955, 'akio0911'],
#       [956, 'yuiseki'],
#     ]

    #member_ids.each{|members|
#      url = "#{url_base}?keyid=g7eyoccKlyrGu9n3xTv4&member_id=955" # akio0911
      #url = "#{url_base}?keyid=g7eyoccKlyrGu9n3xTv4&member_id=#{members[0]}"
      url = "#{url_base}?keyid=g7eyoccKlyrGu9n3xTv4&search_word=%E3%81%AE%E6%98%9F&hit_per_page=100"
      # search_word  	　  	string  	検索ワード  	UTF-8でURLエンコードすること でひっかけるようにする
      open(url) do |http|
        response = http.read
        doc = REXML::Document.new response
         doc.elements.each("response/rest") { |r|
=begin
            # メタプログラミングっぽくしたいが、
            # Rubyにおける変数スコープ仕様に苦戦して挫折…。
            metas = [
              ['contents_id', 'contents_id'],
              ['title', 'title'],
              ['subject', 'subject'],
              ['tag', 'tag'],
              ['member_id', 'member_id'],
              ['auther_name', 'author_name'],
              ['image_url', 'image_url'],
              ['latitude', 'latitude'],
              ['longitude', 'longitude'],
              ['create_date', 'create_date'],
              ['good_count', 'good_count'],
              ['access_count', 'access_count'],
            ]
            metas.each{|a|
              REXML::XPath.match(r, a[0]).each{|e| eval "#{a[1]}=e.text" }
            }
            p contents_id
=end
            contents_id = ''
            title = ''
            subject = ''
            tag = ''
            member_id = ''
            author_name = ''
            image_url = ''
            latitude = ''
            longitude = ''
            create_date = ''
            good_count = ''
            access_count = ''
            REXML::XPath.match(r, "contents_id").each{|e| contents_id=e.text }
            REXML::XPath.match(r, "title").each{|e| title=e.text }
            REXML::XPath.match(r, "subject").each{|e| subject=e.text }
            REXML::XPath.match(r, "tag").each{|e| tag=e.text }
            REXML::XPath.match(r, "member_id").each{|e| member_id=e.text }
            REXML::XPath.match(r, "auther_name").each{|e| author_name=e.text }
            REXML::XPath.match(r, "image_url").each{|e| image_url=e.text }
            REXML::XPath.match(r, "latitude").each{|e| latitude=e.text }
            REXML::XPath.match(r, "longitude").each{|e| longitude=e.text }
            REXML::XPath.match(r, "create_date").each{|e| create_date=e.text }
            REXML::XPath.match(r, "good_count").each{|e| good_count=e.text }
            REXML::XPath.match(r, "access_count").each{|e| access_count=e.text }
            # hash使えばもっと簡単に書ける。ひとまず放置。
            unless Star.find(:first, :conditions => ["contents_id = ?", contents_id] )
              Star.create(:contents_id=>contents_id,
                          :title=>title,
                          :subject=>subject,
                          :tag=>tag,
                          :member_id=>member_id,
                          :author_name=>author_name,
                          :image_url=>image_url,
                          :latitude=>latitude,
                          :longitude=>longitude,
                          :create_date=>create_date,
                          :good_count=>good_count,
                          :access_count=>access_count) if subject =~ /の星/
            end
         }
      end
#    }
  end
end
