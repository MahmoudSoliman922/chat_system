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
        chat = 'application:' + @token + ':chat:' +
               @chat_number + ':message'
        number = $redis.scard(chat) + 1
        if RedisOperations::Message::Validations.new(@token, @chat_number,
                                                     @body).create
          mutex = Thread::Mutex.new
          mutex.synchronize do
            new_chat = chat + ':' + number.to_s
            $redis.hmset(new_chat, 'number', number, 'body', @body)
            $redis.sadd(chat, new_chat)
          end
          { response: number, success: true }
        else
          { number: nil, success: false }
        end
      end
    end
  end
end
