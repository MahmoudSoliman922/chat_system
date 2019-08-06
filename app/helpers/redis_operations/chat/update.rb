# frozen_string_literal: true

module RedisOperations
  module Chat
    class Update
      def initialize(old_token, number, new_token)
        super()
        @old_token = old_token
        @number = number
        @new_token = new_token
      end

      def call
        old_chat = 'application:' + @old_token + ':chat:' + @number
        old_application = 'application:' + @old_token + ':chat'
        new_applicaton = 'application:' + @new_token + ':chat'
        number = $redis.scard(new_applicaton) + 1
        if RedisOperations::Chat::Validations.new(@old_token, @number, @new_token).update
          mutex = Thread::Mutex.new
          mutex.synchronize do
            new_chat = 'application:' + @new_token + ':chat:' + number.to_s
            $redis.hmset(new_chat, 'number', number)
            $redis.sadd(new_applicaton, new_chat)
            $redis.srem(old_application, old_chat)
            $redis.del(old_chat)
          end
          { number: number, success: true }
        else
          { number: nil, success: false }
        end
      end
    end
  end
end
