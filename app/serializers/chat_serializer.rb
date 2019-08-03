# frozen_string_literal: true

class ChatSerializer < ActiveModel::Serializer
  attributes :application_token,
             :number

  def application_token
    application = Application.find_by(id: object.application_id)
    application.application_token
  end
end
