# # frozen_string_literal: true

# require_relative '../serializers/message_serializer'

# class UpdateChatJob < ApplicationJob
#   queue_as :default

#   def perform(chat_number, old_token, new_token)
#     application_id = Shared::GetApplicationIdByToken.new(
#       old_token
#     ).call
#     new_application_id = Shared::GetApplicationIdByToken.new(
#       new_token
#     ).call
#     identifier = { application_id: application_id, number: chat_number }

#     data = { application_id: new_application_id }
#     DatabaseOperations::Update.new(
#       Chat, identifier, data
#     ).call
#   end
# end
