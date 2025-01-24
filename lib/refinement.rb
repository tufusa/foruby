# frozen_string_literal: true

require_relative 'refinement/kernel'
require_relative 'refinement/integer'
require_relative 'refinement/bool'
require_relative 'refinement/float'
require_relative 'refinement/range'
require_relative 'builder/extension'
require_relative 'function/extension'
require_relative 'util/make_alias'
require_relative 'use'

module Foruby
  # Refinement module
  module Refinement
    extend Util::MakeAlias
    @@make_alias = ->(mod, methods) { make_alias mod, methods } # rubocop:disable Style/ClassVars

    # "使われる方"を先にrefineする
    # e.g. `puts true`では`true`が`Kernel#puts`に使われている

    refine TrueClass do
      import_methods BoolRefinement
      @@make_alias[self, BoolRefinement.instance_methods]
    end

    refine FalseClass do
      import_methods BoolRefinement
      @@make_alias[self, BoolRefinement.instance_methods]
    end

    refine Integer do
      import_methods IntegerRefinement
      @@make_alias[self, IntegerRefinement.instance_methods]
    end

    refine Float do
      import_methods FloatRefinement
      @@make_alias[self, FloatRefinement.instance_methods]
    end

    refine Kernel do
      import_methods KernelRefinement
      @@make_alias[self, KernelRefinement.instance_methods]

      import_methods BuilderExtension
      import_methods FunctionExtension
      import_methods UseExtension
    end

    refine Range do
      import_methods RangeRefinement
      @@make_alias[self, RangeRefinement.instance_methods]
    end
  end
end
