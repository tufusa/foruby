# frozen_string_literal: true

require_relative 'core'
require_relative 'refine'
require_relative 'tracer'
require_relative 'feature'

# Foruby top module
module Foruby
  include Refine

  VERSION = '0.1.0'

  def self.init(bin)
    Foruby::Core.top_binding = bin
    Foruby::Tracer.trace bin

    # **FORGIVE ME EVAL IS ONLY THIS ONE I PROMISE**
    bin.eval "using #{Foruby}"

    Feature.new
  end
end
