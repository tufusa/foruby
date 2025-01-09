# frozen_string_literal: true

require_relative 'refinement/kernel'
require_relative 'refinement/integer'
require_relative 'builder/extension'
require_relative 'util/make_alias'

module Foruby
  # Refinement module
  module Refinement
    extend Util::MakeAlias
    @@make_alias = ->(mod, methods) { make_alias mod, methods } # rubocop:disable Style/ClassVars

    refine Kernel do
      import_methods KernelRefinement
      @@make_alias[self, KernelRefinement.instance_methods]

      import_methods BuilderExtension
    end

    refine Integer do
      import_methods IntegerRefinement
      @@make_alias[self, IntegerRefinement.instance_methods]
    end
  end
end
