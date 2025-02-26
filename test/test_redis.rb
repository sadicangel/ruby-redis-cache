# frozen_string_literal: true

require "test_helper"

class TestRedis < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Redis::VERSION
  end

  SERVER_PORT = 42069

  def test_responds_to_ping
    server = Redis::RedisServer.new SERVER_PORT
    Thread.new do server.listen
    end
    socket = TCPSocket.new('localhost', SERVER_PORT)
    socket.write("ping")
    line = socket.readline
    assert_equal "+PONG\r\n", line
  end
end
