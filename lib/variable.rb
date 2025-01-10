# frozen_string_literal: true

require_relative 'foruby'

module Foruby
  # Variable wrapper
  class Variable
    # @dynamic value,value=
    attr_accessor :value
    # @dynamic name
    attr_reader :name

    def initialize(name, value)
      @name = name.to_sym
      @value = value
    end

    def inspect
      @name
    end

    def assignment(value)
      Fragment.new code: "#{name} = #{value}"
    end
  end
end
