# frozen_string_literal: true

module RedisOperations
  module Message
    class Update
      def initialize(token, chat_number, message_number, body)
        super()
        @token = token.to_s
        @chat_number = chat_number.to_s
        @body = body.to_s
        @message_number = message_number.to_s
      end

      def call
        chat = 'application:' + @token + ':chat:' +
               @chat_number + ':message'
        message = chat + ':' + @message_number
        mutex = Thread::Mutex.new
        mutex.synchronize do
          $redis.hmset(message, 'body', @body)
          $redis.sadd(chat, message)
        end
      end
    end
  end
end
