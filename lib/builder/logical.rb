# frozen_string_literal: true

require_relative '../builder'

module Foruby
  # Primitive builder for logical
  class LogicalBuilder < Builder
    def initialize
      @value = nil
      super()
    end

    def set(value = nil)
      @value = value if value
      raise ArgumentError, 'No initial value despite parameter attribute' if @is_parameter && nil.equal?(@value)

      fragment = @value&.then { LogicalFragment.from _1 }
      LogicalFragment.new code: fragment&.inspect || '', builder: self
    end

    def declaration(name)
      attributes = @is_parameter ? ',parameter' : ''
      initial = @value.nil? ? '' : "= .#{@value}."
      Fragment.new code: "logical#{attributes} :: #{name.to_str} #{initial}"
    end
  end
end
