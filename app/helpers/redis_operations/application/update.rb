# frozen_string_literal: true

module RedisOperations
  module Application
    class Update
      def initialize(new_name, token, old_name)
        super()
        @new_name = new_name.to_s
        @token = token.to_s
        @old_name = old_name.to_s
      end

      def call
        application = 'application' + ':' + @token
        $redis.hmset(application, 'name', @new_name)
      end
    end
  end
end
