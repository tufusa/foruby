# frozen_string_literal: true

module Foruby
  # Function wrapper
  class Function
    # @dynamic name, name=
    attr_accessor :name

    def initialize(parameters, return_type, &block)
      @return_type = return_type
      @parameters = parameters
      if @parameters.size != block.parameters.size
        raise ArgumentError,
              "Wrong number of block arguments (given #{block.parameters.size}, expected #{parameters.size})"
      end
      @parameters.keys.zip(block.parameters.map(&:last)) do |expected, given|
        next if expected == given

        raise ArgumentError,
              "Wrong name of block arguments (given #{given}, expected #{expected})"
      end

      # cf. Foruby::Function::_Self
      origin_result = method :result
      block.binding.receiver.define_singleton_method(:result) { origin_result[_1] }

      @function = block
      @definer = definer
    end

    def call(*params)
      if params.size != @parameters.size
        raise ArgumentError,
              "Wrong number of arguments (given #{params.size}, expected #{@parameters.size})"
      end

      params.each { Core.check _1 }
      Fragment.new code: "#{name}(#{params.join ','})"
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
      scope = Core.add_block @function.binding do
        @function[*params]
      end
      variables = scope.variables.map(&:code).join "\n"
      body = scope.fragments.map(&:code).join "\n"

      lambda do |name|
        body.gsub! hash.to_s, name.to_s

        Fragment.new code: <<~CODE
          integer function #{name}(#{@parameters.keys.join ','}) result(ret_#{name})
            implicit none

            #{params_definition}
            #{variables}

            #{body}
          end function #{name}
        CODE
          .chomp
      end
    end

    def result(res)
      Core.check(res) if res.is_a?(Fragment)
      Core.push <<~CODE
        ret_#{hash} = #{res}
        return
      CODE
        .chomp

      res.is_a?(Fragment) ? res : Fragment.new(code: res.inspect)
    end
  end
end
