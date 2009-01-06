#! /usr/bin/env ruby
# rexml/documentでつくりなおすひつようあり
require 'uri'
require 'open-uri'
require 'rexml/document'

class BloggerBlog
	def initialize(username)
		raise unless username
		@uri = URI.parse("http://#{username}.blogspot.com/")
	end
	
	def feeds_uri
		type ||= 'posts'
		return @uri + "feeds/#{type}/default"
	end
end


class HackersBlog < BloggerBlog
	def initialize
		super('hackerscafeblog')
	end

	def logs
		page = open(feeds_uri).read
		doc = REXML::Document.new(page)
		doc.elements.each('feed/entry/title') do |elem|
			puts elem.text
		end
		logs = []
		return logs
	end
end

if __FILE__ == $0 then
	blog = HackersBlog.new
	blog.logs
end

