# frozen_string_literal: true

module Foruby
  # Scope
  class Scope
    # @dynamic variables, fragments, functions
    attr_reader :variables, :fragments, :functions

    def initialize
      @variables = []
      @fragments = []
      @functions = []
    end
  end
end
