# frozen_string_literal: true

module RedisOperations
  module Message
    class Create
      def initialize(token, chat_number, body)
        super()
        @token = token.to_s
        @chat_number = chat_number.to_s
        @body = body.to_s
      end

      def call
        chat = 'application:' + @token + ':chat:' +
               @chat_number + ':message'
        number = $redis.scard(chat) + 1
        mutex = Thread::Mutex.new
        mutex.synchronize do
          new_chat = chat + ':' + number.to_s
          $redis.hmset(new_chat, 'number', number, 'body', @body)
          $redis.sadd(chat, new_chat)
        end
        number
      end
    end
  end
end
