# frozen_string_literal: true

require_relative '../../serializers/application_serializer'

module DatabaseOperations
  class Create
    def initialize(model_class, data, serializer)
      super()
      @model_class = model_class
      @data = data
      @serializer = serializer
    end

    def call
      result = @model_class.new(@data)

      result.save if result.valid?
      if result.valid?
        response = ActiveModelSerializers::SerializableResource.new(
          result,
          serializer: @serializer
        )

        return { response: response, errors: [], redis_data: result }
      else
        return { response: [], errors: result.errors.full_messages ||= [] , redis_data: []}
      end
    end
  end
end
