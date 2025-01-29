# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/logical'

module Foruby
  module Refinement
    # Refinement module for TrueClass/FalseClass
    module BoolRefinement
      def _and(other)
        return method(:"origin_&")[other] unless other.is_a? Fragment

        LogicalFragment.new(inspect) & other
      end

      def _or(other)
        return method(:"origin_|")[other] unless other.is_a? Fragment

        LogicalFragment.new(inspect) | other
      end

      def _xor(other)
        return method(:"origin_^")[other] unless other.is_a? Fragment

        LogicalFragment.new(inspect) ^ other
      end

      def _equal(other)
        return method(:"origin_==")[other] unless other.is_a? Fragment

        LogicalFragment.new(inspect) == other
      end

      def _not_equal(other)
        return method(:"origin_!=")[other] unless other.is_a? Fragment

        LogicalFragment.new(inspect) != other
      end

      def _inspect
        ".#{method(:origin_inspect)[]}."
      end
    end
  end
end
