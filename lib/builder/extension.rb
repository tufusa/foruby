# frozen_string_literal: true

require_relative '../foruby'
require_relative 'integer'
require_relative 'logical'

module Foruby
  # Extension for IntegerBuilder
  module BuilderExtension
    def integer = IntegerBuilder.new

    def logical = LogicalBuilder.new
  end
end
