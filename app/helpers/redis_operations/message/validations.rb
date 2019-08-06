# frozen_string_literal: true

module RedisOperations
  module Message
    class Validations
      def initialize(token, chat_number, body,
                     message_number = nil)
        super()
        @body = body
        @application = $redis.exists('application' + ':' + token)
        @chat = $redis.exists('application:' + token + ':chat:' + chat_number)
        unless message_number.nil?
          @message = $redis.exists('application:' + token + ':chat:' +
             chat_number + ':' + message_number)
        end
      end

      def create
        if @chat == true && @body.blank? == false
          true
        else
          false
        end
      end

      def update
        if @message == true && @body.blank? == false
          true
        else
          false
        end
      end
    end
  end
end
