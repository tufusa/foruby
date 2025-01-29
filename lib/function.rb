# frozen_string_literal: true

module Foruby
  # Function wrapper
  class Function
    # @dynamic name, name=
    attr_accessor :name

    def initialize(parameters, return_type, inline: false, &block)
      @return_type = return_type
      @parameters = parameters
      @is_inline = inline
      unless @parameters.size.equal? block.parameters.size
        raise ArgumentError,
              "Wrong number of block arguments (given #{block.parameters.size}, expected #{parameters.size})"
      end
      @parameters.keys.zip(block.parameters.map(&:last)) do |expected, given|
        next if expected.equal? given

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
      if @is_inline
        code = Fragment.new ''
        Core.add_block(@function.binding) { code = @function[*params] }
        return code
      end

      Fragment.new "#{name}(#{params.join ','})"
    end

    # @dynamic []
    alias [] call

    def definition
      return Fragment.new '' if @is_inline

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
        body.gsub! hash.to_s, name.to_s

        Fragment.new <<~CODE.chomp
          function #{name}(#{@parameters.keys.join ','}) result(ret_#{name})
            #{uses}
            implicit none

            #{params_definition}
            #{variables}
            #{@return_type&.declaration("ret_#{name}")}

            #{body}
          end function #{name}
        CODE
      end
    end

    def result(res)
      Core.push <<~CODE.chomp
        ret_#{hash} = #{res}
        return
      CODE

      res.is_a?(Fragment) ? res : Fragment.new(res.inspect)
    end
  end
end
