# frozen_string_literal: true

require_relative '../fragment'

module Foruby
  # Fragment for logical
  class LogicalFragment < Fragment
    def !
      Core.check self
      self.class.new(code: "(.not. #{inspect})").tap { Core.push _1 }
    end

    def &(other)
      Core.check self
      Core.check other
      other = self.class.from other
      self.class.new(code: "(#{inspect} .and. #{other.inspect})").tap { Core.push _1 }
    end

    def |(other)
      Core.check self
      Core.check other
      other = self.class.from other
      self.class.new(code: "(#{inspect} .or. #{other.inspect})").tap { Core.push _1 }
    end

    def ^(other)
      self != other
    end

    def ==(other)
      Core.check self
      Core.check other
      other = self.class.from other
      self.class.new(code: "(#{inspect} .eqv. #{other.inspect})").tap { Core.push _1 }
    end

    def !=(other)
      Core.check self
      Core.check other
      other = self.class.from other
      self.class.new(code: "(#{inspect} .neqv. #{other.inspect})").tap { Core.push _1 }
    end

    def self.from(value)
      return value if value.is_a?(LogicalFragment)

      new(code: ".#{value}.")
    end
  end
end
