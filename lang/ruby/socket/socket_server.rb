class SocketServer
  def initialize(port=nil)
    puts "create server.."
    @port = port || 8001
  end
  
  def open(port=nil)
    @port = port if(!port.nil?)
    @gs = TCPServer.open @port
    @clients = []
    puts "open server #{@port}"
    
    while true
      Thread.start(@gs.accept) do |s|
        open_client s
        while(message = s.gets)
          send_message_all(message)
        end
        close_client s
      end
    end
  end
  
  def open_client(client)
    puts "#{client} is connected."
    @clients << client;
  end
  
  def close_client(client)
    puts "#{client} is closed."
    @clients.delete client
  end

  def send_message_all(message)
    puts "[message all] #{message}"
    @clients.each do |client|
      send_message(client, message)
    end
  end
  
  def send_message(target, message)
    message.chomp!
    target.write(message << "\n")
  end
end
