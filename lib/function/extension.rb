# frozen_string_literal: true

require_relative '../foruby'
require_relative '../function'
require_relative 'void_function'

module Foruby
  # Extension for Function
  module FunctionExtension
    # @dynamic function
    def function(parameters, return_type = nil, &block)
      if return_type
        Function.new parameters, return_type, &block
      else
        block.then do
          # @type var block: untyped
          # @type var _1: ^(*untyped) -> untyped
          VoidFunction.new parameters, &_1
        end
      end
    end
  end
end
