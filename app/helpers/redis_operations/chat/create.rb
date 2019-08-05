# frozen_string_literal: true

module RedisOperations
  module Chat
    class Create
      def initialize(token)
        super()
        @token = token
      end

      def call
        application = 'application' + ':' + @token
        number = $redis.scard(application + ':' + 'chat') + 1
        new_chat = 'application' + ':' + @token + ':' + 'chat' + number.to_s
        $redis.hmset(new_chat, 'number', number)
        $redis.sadd(application + ':' + 'chat', new_chat)
        number
      end
    end
  end
end