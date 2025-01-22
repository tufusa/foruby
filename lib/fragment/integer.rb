require_relative '../fragment'

module Foruby
  class IntegerFragment < Foruby::Fragment
    def +(other)
      Core.check self
      Core.check other
      fragment = IntegerFragment.new code: "(#{inspect} + #{other.inspect})"
      fragment.tap { Core.push _1 }
    end

    def -(other)
      Core.check self
      Core.check other
      fragment = IntegerFragment.new code: "(#{inspect} - #{other.inspect})"
      fragment.tap { Core.push _1 }
    end

    def *(other)
      Core.check self
      Core.check other
      fragment = IntegerFragment.new code: "(#{inspect} * #{other.inspect})"
      fragment.tap { Core.push _1 }
    end

    def /(other)
      Core.check self
      Core.check other
      fragment = IntegerFragment.new code: "(#{inspect} / #{other.inspect})"
      fragment.tap { Core.push _1 }
    end

    def abs
      Core.check self
      IntegerFragment.new(code: "abs(#{inspect})").tap { Core.push _1 }
    end

    def ==(other)
      Core.check self
      Core.check other
      Core.push "#{inspect} == #{other.inspect}"
    end
  end
end
