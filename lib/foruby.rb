# frozen_string_literal: true

require_relative 'core'
require_relative 'refinement'
require_relative 'tracer'

# Foruby top module
module Foruby
  include Refinement

  VERSION = '0.1.0'
end
