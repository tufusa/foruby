# frozen-string-literal: true

require_relative '../foruby'

module Foruby
  # Extension for Integer & IntegerFragment Range object
  module IntegerSpaceshipExtension
    def _spaceship(other)
      # @type self: Integer
      return -(other <=> self) if other.is_a? IntegerFragment

      method(:origin_spaceship)[other]
    end

    # @dynamic origin_spaceship, <=>
    alias origin_spaceship <=>
    alias <=> _spaceship
  end
end
