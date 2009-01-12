require 'rubygems'
require 'mechanize'
require 'cgi'
require 'kconv'
require 'open-uri'

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

agent = WWW::Mechanize.new
page = Hpricot(open("http://agilemedia.jp/"))
opml = SimpleOPML.new("AMN")
page.search("//p[@class='blogTitle']").each do |elem|
  elem.search("a").each do |elem| 
    url = elem.attributes['href'] 
    opml.add(url, url, url)
  end
end

puts opml
