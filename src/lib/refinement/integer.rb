# frozen_string_literal: true

require_relative '../foruby'
require_relative '../fragment/integer'

module Foruby
  module Refinement
    # Refinement module for Integer
    module IntegerRefinement
      def _plus(other)
        case other
        when Integer, Float then method(:"origin_+")[other]
        when IntegerFragment then IntegerFragment.new(inspect) + other
        when RealFragment then RealFragment.new(inspect) + other
        else raise ArgumentError
        end
      end

      def _minus(other)
        case other
        when Integer, Float then method(:"origin_-")[other]
        when IntegerFragment then IntegerFragment.new(inspect) - other
        when RealFragment then RealFragment.new(inspect) - other
        else raise ArgumentError
        end
      end

      def _multiple(other)
        case other
        when Integer, Float then method(:"origin_*")[other]
        when IntegerFragment then IntegerFragment.new(inspect) * other
        when RealFragment then RealFragment.new(inspect) * other
        else raise ArgumentError
        end
      end

      def _divide(other)
        case other
        when Integer, Float then method(:"origin_/")[other]
        when IntegerFragment then IntegerFragment.new(inspect) / other
        when RealFragment then RealFragment.new(inspect) / other
        else raise ArgumentError
        end
      end

      def _mod(other)
        case other
        when Integer then method(:"origin_-")[other]
        when IntegerFragment then IntegerFragment.new(inspect) - other
        else raise ArgumentError
        end
      end

      def _equal(other)
        case other
        when Integer, Float then method(:"origin_==")[other]
        when IntegerFragment then IntegerFragment.new(inspect) == other
        when RealFragment then RealFragment.new(inspect) == other
        else raise ArgumentError
        end
      end

      def _not_equal(other)
        case other
        when Integer, Float then method(:"origin_!=")[other]
        when IntegerFragment then IntegerFragment.new(inspect) != other
        when RealFragment then RealFragment.new(inspect) != other
        else raise ArgumentError
        end
      end

      # IntegerとIntegerFragmentが混在したRangeを作るためのオーバーライド
      def _spaceship(other)
        return 0 if other.is_a? IntegerFragment

        method(:"origin_<=>")[other]
      end
    end
  end
end
