# frozen_string_literal: true

module Shared
  class GetChatIdByApplicationIdAndNumber
    def initialize(application_id, chat_number)
      super()
      @application_id = application_id
      @chat_number = chat_number
    end

    def call
      chat = Chat.find_by(application_id: @application_id, number: chat_number)
      return chatt.id unless chat.blank?

      nil
    end
  end
end
