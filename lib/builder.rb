# frozen_string_literal: true

require_relative 'foruby'

module Foruby
  # Primitive builder
  class Builder
    def build
      raise NotImplementedError, 'Must be overrided'
    end

    def declaration(name)
      raise NotImplementedError, 'Must be overrided'
    end
  end
end
