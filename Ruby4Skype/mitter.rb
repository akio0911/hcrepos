class Mitter
  USERS = [
    "yuiseki",
    "jazzanova",
    "send",
    "vaac",
    "otsune",
    "takano32",
    "retlet",
    "tacke",
    "yusukezzz",
    "twitt",
    "skashu",
    "moedra",
    "fazz0611",
    "aduma",
    "TKWx"
  ]
=begin
    "llcheesell",
    "delphie",
    "urabi_sama",
    "kagawa",
    "youzaka",
=end

  def self.logs_of_groups
    agent = WWW::Mechanize.new
    agent.max_history = 1
    page = agent.get('http://mitter.jp/groups/25/posts')
    page.body = page.body.toutf8
    logs = []
    page.search('div.video').each do |log|
      title = log.search('div.video-info').search('a').first.get_attribute(:title)
      url = log.search('span.service').search('a').first.get_attribute(:href)
      user = log.search('div.date').search('a').first.inner_text
      time_row = log.search('div.date').search('span').first.get_attribute(:title)
      time = Time.parse(time_row)+(60*60*9)
      text = user + "が動画を共有:\n " + title + "\n" + url
      logs.push({:text => text, :time => time})
    end
    return logs
  end

  def self.logs_of_users
    logs = []
    agent = WWW::Mechanize.new
    agent.max_history = 1
    USERS.each do |user|
      url = "http://mitter.jp/" + user
      page = agent.get(url)
      page.body = page.body.toutf8
      page.search('div.log-details').each do |log|
        title = log.search('h3.title').search('a').first.inner_text
        url = log.search('span.service').search('a').first.get_attribute(:href)
        time_row = log.search('span.watched-at').first.get_attribute(:title)
        time = Time.parse(time_row)+(60*60*9)
        text = user +  "が動画Mitter: " + title + "\n" + url
        logs.push({:text => text, :time => time})
        #p user + " " + logs.length.to_s
      end
    end
    return logs
  end

end
