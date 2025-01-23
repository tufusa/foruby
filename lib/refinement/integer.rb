# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/integer'

module Foruby
  module Refinement
    # Refinement module for Integer
    module IntegerRefinement
      def _plus(other)
        IntegerFragment.new(code: inspect) + other
      end

      def _minus(other)
        IntegerFragment.new(code: inspect) - other
      end

      def _multiple(other)
        IntegerFragment.new(code: inspect) * other
      end

      def _divide(other)
        IntegerFragment.new(code: inspect) / other
      end

      def _abs
        IntegerFragment.new(code: inspect).abs
      end

      def _equal(other)
        IntegerFragment.new(code: inspect) == other
      end

      def _not_equal(other)
        IntegerFragment.new(code: inspect) != other
      end
    end
  end
end
