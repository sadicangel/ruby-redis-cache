# frozen_string_literal: true

require "socket"

module Redis
  class RedisServer
    def initialize(port)
      @server = TCPServer.new(port)
    end

    def listen
      # loop do
        client = @server.accept
        client.puts "+PONG\r\n"
        client.close
      # end
    end
  end
end
