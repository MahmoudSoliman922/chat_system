# frozen_string_literal: true

require_relative '../serializers/message_serializer'

class InsertMessageJob < ApplicationJob
  queue_as :default

  def perform(message_number, body, token, chat_number)
    application_id = Shared::GetApplicationIdByToken.new(
      token
    ).call
    chat_id = Shared::GetChatIdByApplicationIdAndNumber.new(
      application_id, chat_number
    ).call
    data = { chat_id: chat_id, number: message_number, body: body }
    DatabaseOperations::Create.new(
      Message, data, MessageSerializer
    ).call
  end
end
