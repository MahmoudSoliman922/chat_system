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
      if RedisOperations::Chat::Validations.new(params['application_application_token']).create
        number = RedisOperations::Chat::Create.new(params['application_application_token']).call
        InsertChatJob.perform_later(number, params['application_application_token'])
        render_json send_success(number: number)
      else
        render_json send_error
      end
    end

    # def update
    #   if RedisOperations::Chat::Validations.new(params['application_application_token'],
    #                                             params['chat_number'],
    #                                             params['new_application_token']).update
    #     RedisOperations::Chat::Update.new(params['application_application_token'],
    #                                       params['chat_number'], params['new_application_token']).call
    #     UpdateChatJob.perform_later(params['application_application_token'],
    #                                 params['chat_number'],
    #                                 params['new_application_token'])
    #     render_json send_success
    #   else
    #     render_json send_error
    #   end
    # end
  end
end
