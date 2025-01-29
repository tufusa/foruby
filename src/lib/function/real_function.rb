# frozen_string_literal: true

require_relative '../function'
require_relative '../fragment/real'

module Foruby
  # Function returns RealFragment
  class RealFunction < Function
    def call(*param)
      RealFragment.new super(*param).code
    end

    # @dynamic []
    alias [] call
  end
end
