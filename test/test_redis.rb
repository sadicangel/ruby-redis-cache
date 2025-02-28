# frozen_string_literal: true

require "test_helper"

class TestRedis < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil RC::VERSION
  end

  def test_responds_to_ping
    server = RC.start_server
    redis = Redis.new(port: server.port)
    response = redis.ping
    assert_equal "PONG", response
  end

  def test_multiple_commands_from_same_client
    server = RC.start_server
    r = Redis.new(port: server.port)

    r.without_reconnect do
      assert_equal "PONG", r.ping
      assert_equal "PONG", r.ping
    end
  end

  def test_multiple_clients
    server = RC.start_server
    r1 = Redis.new(port: server.port)
    r2 = Redis.new(port: server.port)

    assert_equal "PONG", r1.ping
    assert_equal "PONG", r2.ping
  end
end
