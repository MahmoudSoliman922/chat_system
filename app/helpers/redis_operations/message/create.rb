# frozen_string_literal: true

module RedisOperations
  module Message
    class Create
      def initialize(token, chat_number, body)
        super()
        @token = token
        @chat_number = chat_number
        @body = body
      end

      def call
        chat = 'application' + ':' + @token + ':' + 'chat' + ':' +
               @chat_number + ':' + 'message'
        number = $redis.scard(chat) + 1
        new_chat = chat + ':' + number.to_s
        $redis.hmset(new_chat, 'number', number, 'body', @body)
        $redis.sadd(chat, new_chat)

        chats = $redis.smembers(chat)
        number
      end
    end
  end
end
