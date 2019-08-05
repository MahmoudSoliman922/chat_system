# frozen_string_literal: true

module RedisOperations
  module Application
    class GetAll
      def initialize
        super()
      end

      def call
        all_applications = []
        result = { response: nil }
        if $redis.smembers('application').length.positive?
          applications = $redis.smembers('application')
          applications.each do |application|
            all_applications.push($redis.hgetall(application))
          end
        end
        result[:response] = all_applications
        result
      end
    end
  end
end
