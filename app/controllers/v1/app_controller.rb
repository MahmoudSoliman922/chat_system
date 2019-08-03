# frozen_string_literal: true

require_relative '../../serializers/application_serializer'

module V1
  # applications class
  class AppController < ApplicationController
    def index
      render_json DatabaseOperations::GetAll.new(
        Application, ApplicationSerializer
      ).call
    end

    def create
      data = { name: params['name'] }
      render_json DatabaseOperations::Create.new(
        Application, data, ApplicationSerializer
      ).call
    end

    def update
      puts params
      identifier = { application_token: params['application_token'] }
      data = { name: params['name'] }
      render_json DatabaseOperations::Update.new(
        Application, identifier, data
      ).call
    end
  end
end
