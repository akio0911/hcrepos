#!/usr/bin/env ruby
# iKnow API を利用するためのプロキシ
# クロスサイトにリクエストを出すために利用
# method: post, get, delete
# query: query string
# data: 

require 'cgi'
require 'open-uri'


class WebServiceProxy
end

class IknowApiProxy < WebServiceProxy
	@@uri = URI.parse('http://api.iknow.co.jp/')
	def initialize(api_key)
		@api_key = api_key
	end
end

