# frozen_string_literal: true

module RedisOperations
  module Message
    class Update
      def initialize(token, chat_number, message_number, body)
        super()
        @token = token
        @chat_number = chat_number
        @body = body
        @message_number = message_number
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
