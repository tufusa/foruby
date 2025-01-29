# frozen_string_literal: true

require_relative '../foruby'
require_relative '../function'
require_relative 'void_function'
require_relative 'integer_function'
require_relative 'real_function'
require_relative 'logical_function'

module Foruby
  # Extension for Function
  module FunctionExtension
    # @dynamic function
    def function(parameters, return_type = nil, inline: false, &block)
      case return_type
      when IntegerBuilder then IntegerFunction.new parameters, return_type, inline:, &block
      when RealBuilder then RealFunction.new parameters, return_type, inline:, &block
      when LogicalBuilder then LogicalFunction.new parameters, return_type, inline:, &block
      when nil
        block.then do # type narrowing
          # @type var block: untyped
          # @type var _1: ^(*untyped) -> untyped
          VoidFunction.new parameters, &_1
        end
      else
        raise NotImplementedError, 'Not implemented type'
      end
    end
  end
end
