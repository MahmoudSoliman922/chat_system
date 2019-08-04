# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :chat_number,
             :message_number,
             :application_token,
             :body

  def application_token
    chat = Chat.find_by(id: object.chat_id)

    application = Application.find_by(id: chat.application_id)
    application.application_token
  end

  def chat_number
    chat = Chat.find_by(id: object.chat_id)
    chat.number
  end

  def message_number
    object.number
  end
end
