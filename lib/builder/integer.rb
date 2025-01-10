# frozen_string_literal: true

require_relative '../builder'

module Foruby
  # Primitive builder for integer
  class IntegerBuilder < Builder
    def initialize
      @value = nil
      super()
    end

    def set(value = nil)
      @value = value.to_int if value
      raise ArgumentError, 'No initial value despite parameter attribute' if @is_parameter && nil.equal?(@value)

      IntegerFragment.new code: @value&.inspect || '', builder: self
    end

    def declaration(name)
      attributes = @is_parameter ? ',parameter' : ''
      initial = @value.nil? ? '' : "= #{@value}"
      Fragment.new code: "integer#{attributes} :: #{name.to_str} #{initial}"
    end
  end
end
