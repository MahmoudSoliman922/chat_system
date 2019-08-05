# frozen_string_literal: true

require_relative '../../serializers/chat_serializer'

module V1
  # chats class
  class ChatController < ApplicationController
    def index
      chats = RedisOperations::Chat::GetAll.new(params['application_application_token']).call
      response = if chats[:response].blank? == false
                   chats
                 else
                   application_id = Shared::GetApplicationIdByToken.new(
                     params['application_application_token']
                   ).call
                   identifier = { application_id: application_id }
                   DatabaseOperations::GetAll.new(
                     Chat, ChatSerializer, identifier
                   ).call
                 end
      render_json response
    end

    def create
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call
      number = RedisOperations::Chat::Create.new(params['application_application_token']).call
      data = { application_id: application_id, number: number }

      render_json DatabaseOperations::Create.new(
        Chat, data, ChatSerializer
      ).call
    end

    def update
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call
      new_application_id = Shared::GetApplicationIdByToken.new(
        params['new_application_token']
      ).call
      identifier = { application_id: application_id, number: params['chat_number'] }
      RedisOperations::Chat::Update.new(params['application_application_token'],
                                        params['chat_number'], params['new_application_token']).call

      data = { application_id: new_application_id }
      render_json DatabaseOperations::Update.new(
        Chat, identifier, data
      ).call
    end
  end
end
