# frozen_string_literal: true

module DatabaseOperations
  class GetAll
    def initialize(model_class, serializer, identifier)
      super()
      @model_class = model_class
      @serializer = serializer
      @identifier = identifier
    end

    def call
      result = @model_class.where(@identifier)
      response = ActiveModelSerializers::SerializableResource.new(
        result,
        each_serializer: @serializer
      )
      { response: response, errors: [] }
    end
  end
end
