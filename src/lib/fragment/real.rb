# frozen_string_literal: true

require_relative '../fragment'

module Foruby
  # Fragment for real
  class RealFragment < Fragment
    def +@
      self.class.new("(+#{inspect})")
    end

    def -@
      self.class.new("(-#{inspect})")
    end

    def +(other)
      self.class.new("(#{inspect} + #{other.inspect})")
    end

    def -(other)
      self.class.new("(#{inspect} - #{other.inspect})")
    end

    def *(other)
      self.class.new("(#{inspect} * #{other.inspect})")
    end

    def /(other)
      self.class.new("(#{inspect} / #{other.inspect})")
    end

    def **(other)
      self.class.new("(#{inspect}**#{other.inspect})")
    end

    def abs
      self.class.new("abs(#{inspect})")
    end

    def ==(other)
      LogicalFragment.new("#{inspect} == #{other.inspect}")
    end

    def !=(other)
      LogicalFragment.new("#{inspect} /= #{other.inspect}")
    end
  end
end
