# frozen_string_literal: true

require "socket"

module RC
  class RedisServer
    # @param [int] port
    def initialize(port = 0)
      @server = TCPServer.new("0.0.0.0", port)
      @clients = []
      @port = @server.addr[1]
    end

    attr_reader :port

    def listen
      loop do
        watch_list = [@server, *@clients]
        read, _write, _error = IO.select(watch_list)
        read.each do |ready|
          if ready == @server
            @clients << @server.accept
          else
            handle(ready)
          end
        end
      end
    end

    # @param [TCPSocket] client
    def handle(client)
      client.readpartial(1024) # TODO: Read actual command
      client.write("+PONG\r\n")
    end
  end
end
