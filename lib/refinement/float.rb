# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/real'

module Foruby
  module Refinement
    # Refinement module for Float
    module FloatRefinement
      def _plus(other)
        return method(:"origin_+")[other] unless other.is_a? Fragment

        RealFragment.new(inspect) + other
      end

      def _minus(other)
        return method(:"origin_-")[other] unless other.is_a? Fragment

        RealFragment.new(inspect) - other
      end

      def _multiple(other)
        return method(:"origin_*")[other] unless other.is_a? Fragment

        RealFragment.new(inspect) * other
      end

      def _divide(other)
        return method(:"origin_/")[other] unless other.is_a? Fragment

        RealFragment.new(inspect) / other
      end

      def _power(other)
        return method(:"origin_**")[other] unless other.is_a? Fragment

        RealFragment.new(inspect)**other
      end

      def _equal(other)
        return method(:"origin_==")[other] unless other.is_a? Fragment

        RealFragment.new(inspect) == other
      end

      def _not_equal(other)
        return method(:"origin_!=")[other] unless other.is_a? Fragment

        RealFragment.new(inspect) != other
      end
    end
  end
end
