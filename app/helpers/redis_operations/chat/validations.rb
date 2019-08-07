# frozen_string_literal: true

module RedisOperations
  module Chat
    class Validations
      def initialize(token, number = nil, new_token = nil)
        super()
        @application = $redis.exists('application:' + token)
        unless number.blank?
          @chat = $redis.exists('application:' + token +
            ':chat:' + number)
        end
        unless new_token.blank?
          @new_application = $redis.exists('application:' +
             new_token)
        end
      end

      def create
        @application == true
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
