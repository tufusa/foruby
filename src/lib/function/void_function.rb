# frozen_string_literal: true

require_relative '../foruby'
require_relative '../function'

module Foruby
  # Void function (subroutine) wrapper
  class VoidFunction
    # @dynamic name, name=
    attr_accessor :name

    def initialize(parameters, &block)
      @parameters = parameters
      unless @parameters.size.equal? block.parameters.size
        raise ArgumentError,
              "Wrong number of block arguments (given #{block.parameters.size}, expected #{parameters.size})"
      end
      @parameters.keys.zip(block.parameters.map(&:last)) do |expected, given|
        next if expected.equal? given

        raise ArgumentError,
              "Wrong name of block arguments (given #{given}, expected #{expected})"
      end

      @function = block
      @definer = definer
    end

    def call(*params)
      if params.size != @parameters.size
        raise ArgumentError,
              "Wrong number of arguments (given #{params.size}, expected #{@parameters.size})"
      end

      Core.push "call #{name}(#{params.join ','})"

      nil
    end

    # @dynamic []
    alias [] call

    def definition
      @definer[name]
    end

    private

    def definer
      params = @parameters.map do |name, type|
        case type
        when IntegerBuilder then IntegerFragment.new('').tap { _1.variable = Variable.new name, 0 }
        when RealBuilder then RealFragment.new('').tap { _1.variable = Variable.new name, 0.0 }
        when LogicalBuilder then LogicalFragment.new('').tap { _1.variable = Variable.new name, false }
        else raise NotImplementedError, 'Not impletemted type'
        end
      end
      params_definition = @parameters.map do |name, type|
        type.declaration name.to_s
      end.join "\n"
      scope = Core.add_block @function.binding do
        @function[*params]
      end
      uses = scope.uses.map(&:code).join "\n"
      variables = scope.variables.map(&:code).join "\n"
      body = scope.fragments.map(&:code).join "\n"

      lambda do |name|
        Fragment.new <<~CODE.chomp
          subroutine #{name}(#{@parameters.keys.join ','})
            #{uses}
            implicit none

            #{params_definition}
            #{variables}

            #{body}
          end subroutine #{name}
        CODE
      end
    end
  end
end
