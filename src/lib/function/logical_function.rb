# frozen_string_literal: true

require_relative '../function'
require_relative '../fragment/logical'

module Foruby
  # Function returns LogicalFragment
  class LogicalFunction < Function
    def call(*param)
      LogicalFragment.new super(*param).code
    end

    # @dynamic []
    alias [] call
  end
end
