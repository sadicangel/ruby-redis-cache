# frozen_string_literal: true

require "socket"

module RC
  class RedisServer
    # @param [string] port
    def initialize(port)
      @server = TCPServer.new(port)
    end

    def listen
      loop do
        client = @server.accept
        handle(client)
      end
    end

    # @param [TCPSocket] client
    def handle(client)
      Thread.new do
        loop do
          client.write("+PONG\r\n")
        end
      end
    end
  end
end
