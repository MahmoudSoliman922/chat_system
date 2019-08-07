# frozen_string_literal: true

module RedisOperations
  module Application
    class Create
      def initialize(name, token)
        super()
        @name = name.to_s
        @token = token.to_s
      end

      def call
        new_applicaton = 'application' + ':' + @token
        $redis.hmset(new_applicaton, 'application_token', @token, 'name', @name)
        $redis.sadd('application', new_applicaton)
      end
    end
  end
end
