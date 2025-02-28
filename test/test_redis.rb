# frozen_string_literal: true

require "test_helper"

class TestRedis < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil RC::VERSION
  end

  SERVER_PORT = "42069"

  def test_responds_to_ping
    RC::start_server(SERVER_PORT)
    redis = Redis.new(port: SERVER_PORT)
    response = redis.ping
    assert_equal "PONG", response
  end

  def test_multiple_commands_from_same_client
    RC::start_server(SERVER_PORT)
    r = Redis.new(port: SERVER_PORT)

    r.without_reconnect do
      assert_equal "PONG", r.ping
      assert_equal "PONG", r.ping
    end
  end

  def test_multiple_clients
    RC::start_server(SERVER_PORT)
    r1 = Redis.new(port: SERVER_PORT)
    r2 = Redis.new(port: SERVER_PORT)

    assert_equal "PONG", r1.ping
    assert_equal "PONG", r2.ping
  end
end
