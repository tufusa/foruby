# frozen_string_literal: true

require_relative '../function'
require_relative '../fragment/integer'

module Foruby
  # Function returns IntegerFragment
  class IntegerFunction < Function
    def call(*param)
      IntegerFragment.new super(*param).code
    end

    # @dynamic []
    alias [] call
  end
end
