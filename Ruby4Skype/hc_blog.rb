#! /usr/bin/env ruby
require 'uri'
require 'open-uri'
require 'rexml/document'

class BloggerBlog
	def self.username=(username)
		@@uri = URI.parse("http://#{username}.blogspot.com/")
	end
	def initialize(username)
		raise unless username
	end
	
	def self.feeds_uri
		type ||= 'posts'
		return @@uri + "feeds/#{type}/default"
	end
end


class HackersCafeBlog < BloggerBlog
	self.superclass.username = 'hackerscafeblog'
	def self.feeds_logs
		logs = []
		page = open(feeds_uri).read
		doc = REXML::Document.new(page)
		doc.elements.each('feed/entry') do |entry|
			title = entry.elements['title'].text
			url = entry.elements["link[@rel='alternate']"].attributes['href']
			text = "(coffee) Hacker's Cafe Blog: #{title} - #{url}"
			time = Time.parse(entry.elements['updated'].text)
			logs << {:text => text, :time => time}
		end

		return logs
	end
end

if __FILE__ == $0 then
	p HackersCafeBlog.feeds_logs
end

