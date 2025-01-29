# frozen_string_literal: true

module Foruby
  # Fragment of Fortran code
  class Fragment
    # @dynamic code
    attr_reader :code
    # @dynamic builder
    attr_reader :builder
    # @dynamic variable, variable=
    attr_accessor :variable

    def initialize(code, builder: nil)
      @code = code.to_str
      @builder = builder
      @variable = nil
    end

    def inspect = variable.nil? ? code : variable.name.to_s

    def to_s = variable.nil? ? code : variable.name.to_s
  end
end
