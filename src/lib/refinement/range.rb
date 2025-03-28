# frozen_string_literal: true

module Foruby
  module Refinement
    # Refinement module for Range
    module RangeRefinement
      # @dynamic begin, end, exclude_end?

      def _each(&block)
        params = block.parameters(lambda: true)
        raise ArgumentError, 'Too few argument' if params.empty?
        raise ArgumentError, 'Too many argument' if params.size > 1

        first = self.begin
        last = self.end
        raise ArgumentError, 'Infinite range' unless first && last

        last -= 1 if exclude_end?

        loop_var = IntegerFragment.new ''
        loop_var.variable = Variable.new params[0][1], 0

        Core.add_variable params[0][1], integer
        body = Core.add_block block.binding do
          block[loop_var]
        end.fragments.map(&:code).join "\n"

        Core.push <<~DO.chomp
          do #{loop_var} = #{first}, #{last}
            #{body}
          end do
        DO
      end
    end
  end
end
