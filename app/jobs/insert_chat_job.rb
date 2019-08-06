# frozen_string_literal: true

require_relative '../serializers/chat_serializer'

class InsertChatJob < ApplicationJob
  queue_as :default

  def perform(number, token)
    application_id = Shared::GetApplicationIdByToken.new(token).call
    data = { application_id: application_id, number: number }
    DatabaseOperations::Create.new(
      Chat, data, ChatSerializer
    ).call
  end
end
