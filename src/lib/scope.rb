# frozen_string_literal: true

module Foruby
  # Scope
  class Scope
    # @dynamic uses, variables, fragments, functions
    attr_reader :uses, :variables, :fragments, :functions

    def initialize
      @uses = []
      @variables = []
      @fragments = []
      @functions = []
    end
  end
end
