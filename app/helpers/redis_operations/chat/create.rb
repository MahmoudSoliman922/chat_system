# frozen_string_literal: true

module RedisOperations
  module Chat
    class Create
      def initialize(token)
        super()
        @token = token
      end

      def call
        application = 'application:' + @token
        number = $redis.scard(application + ':chat') + 1
        if RedisOperations::Chat::Validations.new(@token).create
          mutex = Thread::Mutex.new
          mutex.synchronize do
            new_chat = 'application:' + @token + ':chat:' + number.to_s
            $redis.hmset(new_chat, 'number', number)
            $redis.sadd(application + ':chat', new_chat)
          end
          { number: number, success: true }
        else
          { number: nil, success: false }
        end
      end
    end
  end
end
