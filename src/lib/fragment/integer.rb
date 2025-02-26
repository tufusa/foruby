# frozen_string_literal: true

require_relative '../fragment'

module Foruby
  # Fragment for integer
  class IntegerFragment < Fragment
    def +(other)
      self.class.new "(#{inspect} + #{other.inspect})"
    end

    def -(other)
      self.class.new "(#{inspect} - #{other.inspect})"
    end

    def *(other)
      self.class.new "(#{inspect} * #{other.inspect})"
    end

    def /(other)
      self.class.new "(#{inspect} / #{other.inspect})"
    end

    def %(other)
      self.class.new "mod(#{inspect}, #{other.inspect})"
    end

    def abs
      self.class.new "abs(#{inspect})"
    end

    def ==(other)
      LogicalFragment.new "#{inspect} == #{other.inspect}"
    end

    def !=(other)
      LogicalFragment.new "#{inspect} /= #{other.inspect}"
    end

    def <(other)
      LogicalFragment.new "#{inspect} < #{other.inspect}"
    end

    def <=(other)
      LogicalFragment.new "#{inspect} <= #{other.inspect}"
    end

    def >(other)
      LogicalFragment.new "#{inspect} > #{other.inspect}"
    end

    def >=(other)
      LogicalFragment.new "#{inspect} >= #{other.inspect}"
    end

    def even? = self % 2 == 0 # rubocop:disable Style/EvenOdd, Style/NumericPredicate

    def odd? = self % 2 == 1 # rubocop:disable Style/EvenOdd

    def zero? = self == 0 # rubocop:disable Style/NumericPredicate

    # IntegerとIntegerFragmentが混在したRangeを作るためのオーバーライド
    def <=>(_other) = 0
  end
end
