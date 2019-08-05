# frozen_string_literal: true

module RedisOperations
  module Message
    class GetAll
      def initialize(token, chat_number)
        super()
        @token = token
        @chat_number = chat_number
      end

      def call
        all_messages = []
        result = { response: nil }
        chat = 'application' + ':' + @token + ':' + 'chat' + ':' +
               @chat_number + ':' + 'message'

        if $redis.smembers(chat).length.positive?
          chats = $redis.smembers(chat)
          chats.each do |one_chat|
            all_messages.push($redis.hgetall(one_chat))
          end
        end
        result[:response] = all_messages
        result
      end
    end
  end
end
