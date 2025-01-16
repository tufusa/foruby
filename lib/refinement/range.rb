# frozen_string_literal: true

module Foruby
  module Refinement
    # Refinement module for Range
    module RangeRefinement
      # @dynamic begin, end, exclude_end?

      def _each(&block)
        params = block.parameters(lambda: true)
        throw ArgumentError, 'Too few argument' if params.empty?
        throw ArgumentError, 'Too many argument' if params.size > 1

        first = self.begin
        last = self.end
        throw ArgumentError, 'Infinite range' unless first && last

        last = last.send :"origin_-", 1 if exclude_end?

        loop_var = IntegerFragment.new code: ''
        loop_var.variable = Variable.new params[0][1], first

        body = Core.add_block block.binding do
          block[loop_var]
        end
        Core.check(body)

        code = <<~DO
          do #{loop_var} = #{first}, #{last}
            #{body}
          end do
        DO
               .chomp

        Core.push Fragment.new(code:)
      end
    end
  end
end
