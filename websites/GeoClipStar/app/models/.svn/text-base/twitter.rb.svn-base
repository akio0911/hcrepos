require 'open-uri'
require 'rss'
Net::HTTP.version_1_2 

class Twitter < ActiveRecord::Base
  def self.getrss_items(rss_items)
      rss_items = RSS::Parser.parse(rss_items, false)
      rss_items.items.each do  |rss_item|
        unless Twitter.find(:first, :conditions => ["link = ?", rss_item.link])
          Twitter.create(:value => rss_item.description , :link => rss_item.link, :pub_date => rss_item.pubDate.strftime("%Y%m%d %H%M%S"))
        end
      end
  end

  def self.import_twitter
    url = "http://twitter.com/statuses/user_timeline/4147701.rss"

    open(url) do | http | 
      getrss_items(http.read)
    end

    req = Net::HTTP::Get.new('/statuses/replies.rss')
    req.basic_auth 'gaziro2000', '11111111'
    Net::HTTP.start('twitter.com') {|http|

      request = http.request(req)
      getrss_items(request.body)
    }

  end

end
