# frozen_string_literal: true

module DatabaseOperations
  class Update
    def initialize(model_class, identifier, data, serializer)
      super()
      @model_class = model_class
      @data = data
      @identifier = identifier
      @serializer = serializer
    end

    def call
      result = @model_class.where(@identifier).update(@data) unless
       @data[@data.keys[0]].nil? || @identifier[@identifier.keys[0]].nil?

      if @identifier[@identifier.keys[0]] &&
         @data[@data.keys[0]] &&
         result[0][@data.keys[0].to_s] == @data[@data.keys[0]]

        response = ActiveModelSerializers::SerializableResource.new(
          result,
          each_serializer: @serializer
        )
        return { response: response, errors: [] }
      else
        return { response: [], errors: ['Please provide a valid data'] }
      end
    end
  end
end
