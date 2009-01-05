class Github
  def self.coommit_logs
    logs = []
    xml = open("http://github.com/feeds/akio0911/commits/hcrepos/master").read
    doc = REXML::Document.new xml
    doc.elements.each('/feed') do |feed|
      feed.elements.each('entry') do |entry|
        status_text = entry.elements['author/name'].text + ':' + entry.elements['title'].text
        status_created_at = Time.parse(entry.elements['updated'].text)
        status_created_at += 9.hour + 8.hour
        logs.push({:text => status_text, :time => status_created_at})
      end
    end
    return logs
  end
end
