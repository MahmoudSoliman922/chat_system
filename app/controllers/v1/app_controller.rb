# frozen_string_literal: true

require_relative '../../serializers/application_serializer'

module V1
  # applications class
  class AppController < ApplicationController
    def index
      applications = RedisOperations::Application::GetAll.new.call
      response = if applications.blank? == false
                   applications
                 else
                   DatabaseOperations::GetAll.new(
                     Application, ApplicationSerializer
                   ).call
                 end
      render_json response
    end

    def create
      data = { name: params['name'] }
      result = DatabaseOperations::Create.new(
        Application, data, ApplicationSerializer
      ).call
      RedisOperations::Application::Create.new(params['name'], result[:redis_data].application_token).call if result[:errors].blank?
      render_json result
    end

    def update
      old_data = Application.find_by(application_token: params['application_token'])
      identifier = { application_token: params['application_token'] }
      data = { name: params['name'] }
      result = DatabaseOperations::Update.new(
        Application, identifier, data
      ).call
      if result[:errors].blank?
        # change this to take the first 2 parameters from the request
        RedisOperations::Application::Update.new(result[:redis_data].name,
                                                 result[:redis_data].application_token,
                                                 old_data.name).call
      end
      render_json result
    end
  end
end
