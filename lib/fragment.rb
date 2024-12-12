# frozen_string_literal: true

module Foruby
  # Fragment of Fortran code
  class Fragment
    # @dynamic code
    attr_reader :code

    def initialize(code:)
      @code = code.to_str
    end

    def inspect = code

    def to_s = code
  end
end
