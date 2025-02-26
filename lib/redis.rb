# frozen_string_literal: true

require_relative "redis/version"
require_relative "redis/redis_server"

module Redis
  class Error < StandardError; end
end
