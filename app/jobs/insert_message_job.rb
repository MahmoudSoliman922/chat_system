# frozen_string_literal: true

require_relative '../serializers/message_serializer'

class InsertMessageJob < ApplicationJob
  queue_as :default

  def perform(data)
    DatabaseOperations::Create.new(
      Message, data, MessageSerializer
    ).call
  end
end
