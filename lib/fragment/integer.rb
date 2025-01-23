# frozen_string_literal: true

require_relative '../fragment'

module Foruby
  # Fragment for integer
  class IntegerFragment < Fragment
    def +(other)
      Core.check self
      Core.check other
      self.class.new(code: "(#{inspect} + #{other.inspect})").tap { Core.push _1 }
    end

    def -(other)
      Core.check self
      Core.check other
      self.class.new(code: "(#{inspect} - #{other.inspect})").tap { Core.push _1 }
    end

    def *(other)
      Core.check self
      Core.check other
      self.class.new(code: "(#{inspect} * #{other.inspect})").tap { Core.push _1 }
    end

    def /(other)
      Core.check self
      Core.check other
      self.class.new(code: "(#{inspect} / #{other.inspect})").tap { Core.push _1 }
    end

    def abs
      Core.check self
      self.class.new(code: "abs(#{inspect})").tap { Core.push _1 }
    end

    def ==(other)
      Core.check self
      Core.check other
      LogicalFragment.new(code: "#{inspect} == #{other.inspect}").tap { Core.push _1 }
    end

    def !=(other)
      Core.check self
      Core.check other
      LogicalFragment.new(code: "#{inspect} /= #{other.inspect}").tap { Core.push _1 }
    end
  end
end
