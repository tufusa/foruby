# frozen_string_literal: true

require_relative '../builder'

module Foruby
  # Primitive builder for real
  class RealBuilder < Builder
    def initialize
      @value = nil
      super()
    end

    def set(value = nil)
      @value = value.to_f if value
      raise ArgumentError, 'No initial value despite parameter attribute' if @is_parameter && nil.equal?(@value)

      RealFragment.new code: @value&.inspect || '', builder: self
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
      initial = @value.nil? ? '' : "= #{@value}"
      Fragment.new code: "real#{attributes} :: #{name.to_str} #{initial}"
    end
  end
end
