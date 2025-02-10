# frozen_string_literal: true

require_relative '../fragment'

module Foruby
  # Fragment for logical
  class LogicalFragment < Fragment
    def !
      self.class.new("(.not. #{inspect})")
    end

    def &(other)
      other = self.class.from other
      self.class.new("(#{inspect} .and. #{other.inspect})")
    end

    def |(other)
      other = self.class.from other
      self.class.new("(#{inspect} .or. #{other.inspect})")
    end

    def ^(other)
      self != other
    end

    def ==(other)
      other = self.class.from other
      self.class.new("(#{inspect} .eqv. #{other.inspect})")
    end

    def !=(other)
      other = self.class.from other
      self.class.new("(#{inspect} .neqv. #{other.inspect})")
    end

    def self.from(value)
      return value if value.is_a?(LogicalFragment)

      new(".#{value}.")
    end
  end
end
