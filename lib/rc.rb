# frozen_string_literal: true

require "rc/version"
require "rc/redis_server"

module RC
  class Error < StandardError; end

  # @param [string] port
  def self.start_server(port)
    server = RedisServer.new(port)
    Thread.new { server.listen }
    server
  end
end
