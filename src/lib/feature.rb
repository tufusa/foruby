# frozen_string_literal: true

require_relative 'foruby'
require_relative 'if_builder'

module Foruby
  # Common feature interface
  class Feature
    def if(condition, &block)
      IfBuilder.new condition, &block
    end

    def eval(program)
      Core.push program
      nil
    end
  end
end
