# frozen_string_literal: true
module GraphQL
  # Raised automatically when a field's resolve function returns `nil`
  # for a non-null field.
  class InvalidNullError < GraphQL::TypeError
    # @return [GraphQL::BaseType] The owner of {#field}
    attr_reader :parent_type

    # @return [GraphQL::Field] The field which failed to return a value
    attr_reader :field

    # @return [nil, GraphQL::ExecutionError] The invalid value for this field
    attr_reader :value

    def initialize(parent_type, field, value)
      @parent_type = parent_type
      @field = field
      @value = value
      super("Cannot return null for non-nullable field #{@parent_type.name}.#{@field.name}")
    end

    # @return [Hash] An entry for the response's "errors" key
    def to_h
      { "message" => message }
    end

    # @return [Boolean] Whether the null in question was caused by another error
    def parent_error?
      @value.is_a?(GraphQL::ExecutionError)
    end
  end
end
