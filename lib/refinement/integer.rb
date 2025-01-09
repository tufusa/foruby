# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/integer'

module Foruby
  module Refinement
    # Refinement module for Integer
    module IntegerRefinement
      def _plus(other)
        Foruby::IntegerFragment.new(code: inspect) + other
      end

      def _minus(other)
        Foruby::IntegerFragment.new(code: inspect) - other
      end

      def _multiple(other)
        Foruby::IntegerFragment.new(code: inspect) * other
      end

      def _divide(other)
        Foruby::IntegerFragment.new(code: inspect) / other
      end

      def abs
        Foruby::IntegerFragment.new(code: inspect).abs
      end
    end
  end
end
