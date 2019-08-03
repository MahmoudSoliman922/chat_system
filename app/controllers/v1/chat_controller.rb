# frozen_string_literal: true

require_relative '../../serializers/chat_serializer'

module V1
  # chats class
  class ChatController < ApplicationController
    def index
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call
      identifier = { application_id: application_id }

      render_json DatabaseOperations::GetAll.new(
        Chat, ChatSerializer, identifier
      ).call
    end

    def create
      application_id = Shared::GetApplicationIdByToken.new(
        params['application_application_token']
      ).call
      data = { application_id: application_id, number: params['number'] }
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
      data = { application_id: new_application_id }
      render_json DatabaseOperations::Update.new(
        Chat, identifier, data
      ).call
    end
  end
end
