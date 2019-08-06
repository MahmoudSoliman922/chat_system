# frozen_string_literal: true

module RedisOperations
  module Chat
    class Validations
      def initialize(token, number = nil, new_token = nil)
        super()
        @application = $redis.exists('application:' + token)
        @chat = $redis.exists('application:' + token + ':chat:' + number)
        @new_application = $redis.exists('application' + ':' + new_token)
      end

      def create
        @pplication == true
      end

      def update
        if @chat == true && @new_application == true
          true
        else
          false
        end
      end
    end
  end
end
