# frozen_string_literal: true

require_relative '../builder'

module Foruby
  # Primitive builder for real
  class RealBuilder < Builder
    def initialize
      @fragment = nil
      super()
    end

    def set(value = nil)
      code =
        case value
        when nil then nil
        when Fragment then value.inspect
        else value.to_f.inspect
        end
      raise ArgumentError, 'No initial value despite parameter attribute' if @is_parameter && code.nil?

      RealFragment.new(code || '', builder: self).tap { code && @fragment = _1 }
    end

    def declaration(name)
      parameter = @is_parameter ? 'parameter' : nil
      dimension = @dimension&.map do |dim|
        case dim
        when Integer then dim.to_s
        when Range
          # @type var dim: Range[Integer | nil]
          "#{dim.begin}:#{dim.end&.then { dim.exclude_end? ? _1 - 1 : _1 }}"
        end
      end&.then { "dimension(#{_1.join ','})" }

      attributes = [parameter, dimension]
                   .compact.join(',')
                   .then { "#{_1.empty? ? '' : ','}#{_1}" }
      initial = @fragment.nil? ? '' : "= #{@fragment}"
      Fragment.new "real#{attributes} :: #{name.to_str} #{initial}"
    end
  end
end
