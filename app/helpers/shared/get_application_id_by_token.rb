# frozen_string_literal: true

module Shared
  class GetApplicationIdByToken
    def initialize(application_token)
      super()
      @application_token = application_token
    end

    def call
      application = Application.find_by(application_token: @application_token)
      return application.id unless application.blank?

      nil
    end
  end
end
