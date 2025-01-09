# frozen_string_literal: true

require_relative 'foruby'

module Foruby
  # Primitive builder
  class Builder
    def parameter
      raise ArgumentError, 'No initial value despite parameter attribute' if nil.equal? @value

      @is_parameter = true
      self
    end

    def build
      raise NotImplementedError, 'Must be overrided'
    end

    def declaration(name)
      raise NotImplementedError, 'Must be overrided'
    end
  end
end
