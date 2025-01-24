# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/real'

module Foruby
  module Refinement
    # Refinement module for Float
    module FloatRefinement
      def _plus(other)
        RealFragment.new(code: inspect) + other
      end

      def _minus(other)
        RealFragment.new(code: inspect) - other
      end

      def _multiple(other)
        RealFragment.new(code: inspect) * other
      end

      def _divide(other)
        RealFragment.new(code: inspect) / other
      end

      def _abs
        RealFragment.new(code: inspect).abs
      end

      def _equal(other)
        RealFragment.new(code: inspect) == other
      end

      def _not_equal(other)
        RealFragment.new(code: inspect) != other
      end
    end
  end
end
