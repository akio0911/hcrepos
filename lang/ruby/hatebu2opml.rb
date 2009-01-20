# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'
require 'hpricot'
require 'open-uri'
require 'cgi'
require 'kconv'

class SimpleOPML

  Site = Struct.new(:url, :rss, :title)

  def initialize(title)
    @title = title
    @sites = []
  end

  def add(url, rss, title=nil)
    title = get_title(url) if title.nil?
    @sites << Site.new(url, rss, title)
  end

  def get_title(url)
    doc = Hpricot(open(url).read)
    if (title = doc % :title)
      title.inner_html
    else
      ""
    end
  end

  def to_s
    <<EOD
<?xml version="1.0" encoding="utf-8"?>
<opml version="1.0">
<head>
<title>#{CGI.escapeHTML @title}</title>
<dateCreated>#{Time.now.rfc822}</dateCreated>
<ownerName />
</head>
<body>
<outline text="Subscriptions">
#{@sites.map{|s| site_to_outline(s)}}
</outline>
</body>
</opml>
EOD
  end

  def site_to_outline(site)
    %!<outline title="#{CGI.escapeHTML site.title.toutf8}" htmlUrl="#{CGI.escapeHTML site.url}" text="#{CGI.escapeHTML site.title.toutf8}" type="rss" xmlUrl="#{CGI.escapeHTML site.rss}" />\n!
  end
end

URL_BASE = 'http://b.hatena.ne.jp'
URL = "#{URL_BASE}/t"

agent = WWW::Mechanize.new
page = agent.get(URL)
opml = SimpleOPML.new("はてなブックマーク - タグ一覧")
page.search("/html/body/div/div[3]/div/div[2]/ul/li/a").each do |a|
  url = "#{URL_BASE}/t/#{URI.encode(a.inner_html)}"
  rss = "#{URL_BASE}/t/#{URI.encode(a.inner_html)}?sort=hot&threshold=&mode=rss'"
  title = "はてなブックマーク - タグ - #{a.inner_html}"
  opml.add(url, rss, title)
end
puts opml.to_s
