# frozen_string_literal: true

module Shared
  class SearchOnMessages
    def initialize(keyword)
      super()
      @keyword = keyword
    end

    def call
      messages = Message.__elasticsearch__.search('*' + @keyword + '*').as_json
      serialized_messages = messages.map do |n|
        chat = Chat.find_by(id: n['_source']['chat_id'])
        application = Application.find_by(id: chat.application_id)
        { body: n['_source']['body'],
          chat_number: chat.number, message_number: n['_source']['number'],
          application_token: application.application_token }
      end
      result = { response: serialized_messages, errors: [] }
      result
    end
  end
end
