# frozen_string_literal: true

require_relative '../builder'

module Foruby
  # Primitive builder for integer
  class IntegerBuilder < Builder
    def initialize(value = nil)
      @value = value.to_int if value
      super()
    end

    def parameter
      super()
      self
    end

    def build
      IntegerFragment.new code: @value.inspect
    end

    def declaration(name)
      attributes = @is_parameter ? ',parameter' : ''
      initial = @value.nil? ? '' : "= #{@value}"
      Fragment.new code: "integer#{attributes} :: #{name.to_str} #{initial}"
    end
  end
end
