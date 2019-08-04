# frozen_string_literal: true

require_relative '../../serializers/message_serializer'

module V1
  # messages class
  class MessageController < ApplicationController
    def index
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call

      chat_id = Shared::GetChatIdByApplicationIdAndNumber.new(
        application_id, params['chat_chat_number']
      ).call

      identifier = { chat_id: chat_id }

      render_json DatabaseOperations::GetAll.new(
        Message, MessageSerializer, identifier
      ).call
    end

    def create
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call

      chat_id = Shared::GetChatIdByApplicationIdAndNumber.new(
        application_id, params['chat_chat_number']
      ).call

      data = { chat_id: chat_id, number: params['number'], body: params['body'] }
      render_json DatabaseOperations::Create.new(
        Message, data, MessageSerializer
      ).call
    end

    def update
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call

      chat_id = Shared::GetChatIdByApplicationIdAndNumber.new(
        application_id, params['chat_chat_number']
      ).call

      identifier = { chat_id: chat_id, number: params['message_number'] }
      data = { body: params['body'] }
      render_json DatabaseOperations::Update.new(
        Message, identifier, data
      ).call
    end
  end
end
