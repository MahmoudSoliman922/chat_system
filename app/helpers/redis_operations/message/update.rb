# frozen_string_literal: true

module RedisOperations
  module Message
    class Update
      def initialize(token, chat_number, message_number, new_body)
        super()
        @token = token
        @chat_number = chat_number
        @new_body = new_body
        @message_number = message_number
      end

      def call
        chat = 'application' + ':' + @token + ':' + 'chat' + ':' +
               @chat_number + ':' + 'message'
        message = chat + ':' + @message_number

        $redis.hmset(message, 'body', @new_body)
        $redis.sadd(chat, message)
        @message_number
      end
    end
  end
end
