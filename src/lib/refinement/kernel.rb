# frozen_string_literal: true

module Foruby
  module Refinement
    # Refinement module for Kernel
    module KernelRefinement
      def _puts(*value)
        Core.push "print *, #{value.map(&:inspect).join ', '}"
      end

      def _loop(&block)
        body = Core.add_block block.binding do
          block[]
        end.fragments.map(&:code).join "\n"

        Core.push <<~DO.chomp
          do
            #{body}
          end do
        DO
      end

      def exp(value) = RealFragment.new "exp(#{value})"

      def sqrt(value) = RealFragment.new "sqrt(#{value})"

      def cshift(array, shift)
        array.class.new "cshift(#{array}, #{shift})"
      end
    end
  end
end
