# frozen_string_literal: true

require_relative '../../serializers/message_serializer'

module V1
  # messages class
  class MessageController < ApplicationController
    def index
      messages = RedisOperations::Message::GetAll.new(
        params['application_application_token'],
        params['chat_chat_number']
      ).call
      response = if messages[:response].blank? == false
                   messages
                 else
                   application_id = Shared::GetApplicationIdByToken.new(
                     params['application_application_token']
                   ).call
                   chat_id = Shared::GetChatIdByApplicationIdAndNumber.new(
                     application_id, params['chat_chat_number']
                   ).call
                   identifier = { chat_id: chat_id }
                   DatabaseOperations::GetAll.new(
                     Message, MessageSerializer, identifier
                   ).call
                 end

      render_json response
    end

    def create
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call
      chat_id = Shared::GetChatIdByApplicationIdAndNumber.new(
        application_id, params['chat_chat_number']
      ).call
      number = RedisOperations::Message::Create.new(params['application_application_token'],
                                                    params['chat_chat_number'], params['body']).call

      data = { chat_id: chat_id, number: number, body: params['body'] }
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
      RedisOperations::Message::Update.new(params['application_application_token'],
                                           params['chat_chat_number'], params['message_number'], params['body']).call

      data = { body: params['body'] }
      identifier = { chat_id: chat_id, number: params['message_number'] }
      render_json DatabaseOperations::Update.new(
        Message, identifier, data
      ).call
    end

    def search
      result = Shared::SearchOnMessages.new(params['keyword']).call
      render_json result
    end
  end
end
