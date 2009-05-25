require 'rubygems'
require 'eventmachine'

class CharacterCount < EventMachine::Connection
  def post_init
    puts "post_init"
    puts "Received a new connection"
  end

  def receive_data(data)
    puts "receive_data(data)"
    puts "Received data: #{data}"
    send_data "#{data.length} (characters)\r\n"
    close_connection_after_writing
  end

  EventMachine::run do
    host, port = "127.0.0.1", 3793
    EventMachine.start_server(host, port, CharacterCount)
    puts "Now accepting connections on address #{host}, port #{port}"
  end
end
