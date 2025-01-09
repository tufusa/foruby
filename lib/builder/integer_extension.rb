# frozen_string_literal: true

require_relative '../foruby'
require_relative 'integer'

module Foruby
  # Extension for IntegerBuilder
  module IntegerBuilderExtension
    def integer(value = nil)
      IntegerBuilder.new value
    end
  end
end
