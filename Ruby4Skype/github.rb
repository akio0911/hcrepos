class Github
  def self.commit_logs
    logs = []
    xml = open("http://github.com/feeds/akio0911/commits/hcrepos/master").read
    doc = REXML::Document.new xml
    doc.elements.each('/feed') do |feed|
      feed.elements.each('entry') do |entry|
        text = entry.elements['author/name'].text + ':' + entry.elements['title'].text
        time = Time.parse(entry.elements['updated'].text)
        logs.push({:text => text, :time => time})
      end
    end
    return logs
  end
end
