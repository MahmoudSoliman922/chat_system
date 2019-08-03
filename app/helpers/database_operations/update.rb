# frozen_string_literal: true

module DatabaseOperations
  class Update
    def initialize(model_class, identifier, data)
      super()
      @model_class = model_class
      @data = data
      @identifier = identifier
    end

    def call
      result = @model_class.find_by(@identifier)
      result = result.update(@data) unless result.blank?
      if result.blank? != true && result != false
        return { response: [], errors: [] }
      else
        return { response: [], errors: ['Please provide a valid data'] }
      end
    end
  end
end
