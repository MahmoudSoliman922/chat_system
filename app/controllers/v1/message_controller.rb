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
      if RedisOperations::Message::Validations.new(params['application_application_token'],
                                                   params['chat_chat_number'],
                                                   params['body']).create
        number = RedisOperations::Message::Create.new(params['application_application_token'],
                                                      params['chat_chat_number'],
                                                      params['body']).call
        InsertMessageJob.perform_later(number, params['body'],
                                       params['application_application_token'],
                                       params['chat_chat_number'])
        render_json send_success(number: number)
      else
        render_json send_error
      end
    end

    def update
      if RedisOperations::Message::Validations.new(params['application_application_token'],
                                                   params['chat_chat_number'],
                                                   params['body'], params['message_number']).update
        RedisOperations::Message::Update.new(params['application_application_token'],
                                             params['chat_chat_number'],
                                             params['message_number'],
                                             params['body']).call
        UpdateMessageJob.perform_later(params['message_number'], params['body'],
                                       params['application_application_token'],
                                       params['chat_chat_number'])
        render_json send_success
      else
        render_json send_error
      end
    end

    # def search
    #   result = Shared::SearchOnMessages.new(params['keyword']).call
    #   render_json result
    # end
  end
end
