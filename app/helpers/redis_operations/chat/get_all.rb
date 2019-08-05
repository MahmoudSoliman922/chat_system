# frozen_string_literal: true

module RedisOperations
  module Chat
    class GetAll
      def initialize(token)
        super()
        @token = token
      end

      def call
        all_chats = []
        result = { response: nil }
        if $redis.smembers('application' + ':' + @token + ':' + 'chat').length.positive?
          chats = $redis.smembers('application' + ':' + @token + ':' + 'chat')
          chats.each do |chat|
            all_chats.push($redis.hgetall(chat))
          end
        end
        result[:response] = all_chats
        result
      end
    end
  end
end
