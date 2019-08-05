# frozen_string_literal: true

module RedisOperations
  module Application
    class Update
      def initialize(new_name, token, old_name)
        super()
        @new_name = new_name
        @token = token
        @old_name = old_name
      end

      def call
        application = 'application' + ':' + @token
        $redis.hmset(application, 'name', @new_name)
      end
    end
  end
end
