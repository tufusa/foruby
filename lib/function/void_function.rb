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

      params.each { Core.check _1 }
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
      params = @parameters.map do |key, type|
        fragment = case type
                   when IntegerBuilder
                     IntegerFragment.new(code: '')
                   else
                     Fragment.new(code: '')
                   end
        fragment.tap { _1.variable = Variable.new key, 0 }
      end
      params_definition = @parameters.keys.map { "integer, intent(in) :: #{_1}" }.join "\n"
      scope = Core.add_block(@function.binding) do
        @function[*params]
      end
      uses = scope.uses.map(&:code).join "\n"
      variables = scope.variables.map(&:code).join "\n"
      body = scope.fragments.map(&:code).join "\n"

      lambda do |name|
        Fragment.new code: <<~CODE
          subroutine #{name}(#{@parameters.keys.join ','})
            #{uses}

            implicit none

            #{params_definition}
            #{variables}

            #{body}
          end subroutine #{name}
        CODE
          .chomp
      end
    end
  end
end
