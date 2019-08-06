# frozen_string_literal: true

require_relative '../serializers/chat_serializer'

class InsertChatJob < ApplicationJob
  queue_as :default

  def perform(data)
    DatabaseOperations::Create.new(
      Chat, data, ChatSerializer
    ).call
  end
end
