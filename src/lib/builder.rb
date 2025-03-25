# frozen_string_literal: true

require_relative 'foruby'

module Foruby
  # Primitive builder
  class Builder
    def parameter
      @is_parameter = true
      self
    end

    def dimension(*dim)
      @dimension = *dim
      self
    end

    def set(value = nil)
      raise NotImplementedError, 'Must be overrided'
    end

    def declaration(name)
      raise NotImplementedError, 'Must be overrided'
    end
  end
end
