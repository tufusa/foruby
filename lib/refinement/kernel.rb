# frozen_string_literal: true

require_relative '../foruby'

module Foruby
  module Refinement
    # Refinement module for Kernel
    module KernelRefinement
      def _puts(value)
        Core.check value
        Core.push "print *, #{value.inspect}"
      end
    end
  end
end
