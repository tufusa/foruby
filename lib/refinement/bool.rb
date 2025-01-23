# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/logical'

module Foruby
  module Refinement
    # Refinement module for TrueClass/FalseClass
    module BoolRefinement
      def _not
        !LogicalFragment.new(code: method(:origin_inspect)[])
      end

      def _and(other)
        LogicalFragment.new(code: inspect) & other
      end

      def _or(other)
        LogicalFragment.new(code: inspect) | other
      end

      def _xor(other)
        LogicalFragment.new(code: inspect) ^ other
      end

      def _equal(other)
        LogicalFragment.new(code: inspect) == other
      end

      def _not_equal(other)
        LogicalFragment.new(code: inspect) != other
      end

      def _inspect
        ".#{method(:origin_inspect)[]}."
      end
    end
  end
end
