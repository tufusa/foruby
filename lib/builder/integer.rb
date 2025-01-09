# frozen_string_literal: true

require_relative '../builder'

module Foruby
  # Primitive builder for integer
  class IntegerBuilder < Builder
    def initialize(value = nil)
      @value = value.to_int if value
      super()
    end

    def build
      IntegerFragment.new code: @value.inspect
    end

    def declaration(name)
      Fragment.new code: "integer :: #{name.to_str} #{@value.nil? ? '' : "= #{@value}"}"
    end
  end
end
