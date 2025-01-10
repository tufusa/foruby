# frozen_string_literal: true

require_relative '../foruby'
require_relative 'integer'

module Foruby
  # Extension for IntegerBuilder
  module BuilderExtension
    def integer = IntegerBuilder.new
  end
end
