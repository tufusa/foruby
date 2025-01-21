# frozen_string_literal: true

require_relative 'fragment'
require_relative 'scope'

module Foruby
  # Foruby core module
  module Core
    # rubocop:disable Style/ClassVars

    @@scopes = {} # : Hash[Binding, Foruby::Scope]
    @@top_binding = binding

    # rubocop:enable Style/ClassVars

    def self.scopes = @@scopes

    def self.top_binding = @@top_binding

    def self.top_binding=(bin)
      @@top_binding = bin # rubocop:disable Style/ClassVars
    end

    def self.check(code)
      return unless code.is_a? Fragment

      scopes.each_value { |scope| scope.fragments.reject! { _1 == code } }
    end

    def self.push(code)
      scopes[top_binding] = Scope.new unless scopes.key? top_binding

      fragment = code.is_a?(Fragment) ? code : Fragment.new(code:)
      fragment.tap { scopes[top_binding].fragments << _1 }
    end

    def self.add_block(bin, &block)
      scopes[bin] = Scope.new unless scopes.key? bin

      # 一時的にtop_bindingを差し替える
      previous_top_binding = top_binding
      self.top_binding = bin

      block.call

      self.top_binding = previous_top_binding

      scope = scopes[bin]
      scopes.delete bin

      scope
    end
    end
  end
end
