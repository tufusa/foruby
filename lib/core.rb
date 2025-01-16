# frozen_string_literal: true

require_relative 'fragment'

module Foruby
  # Foruby core module
  module Core
    @@fragments = { binding => [Fragment.new(code: '')].clear }.clear # rubocop:disable Style/ClassVars
    @@top_binding = binding # rubocop:disable Style/ClassVars

    def self.fragments = @@fragments

    def self.top_binding = @@top_binding

    def self.top_binding=(bin)
      @@top_binding = bin # rubocop:disable Style/ClassVars
    end

    def self.check(code)
      return unless code.is_a? Fragment

      fragments.transform_values! { |fs| fs.reject { _1 == code } }
    end

    def self.push(code, bin: nil)
      key_binding = bin || top_binding
      fragments[key_binding] = [] unless fragments.key? key_binding

      fragment = code.is_a?(Fragment) ? code : Fragment.new(code:)
      fragment.tap { fragments[key_binding] << _1 }
    end

    def self.add_block(bin, &block)
      # 一時的にtop_bindingを差し替える
      previous_top_binding = top_binding
      self.top_binding = bin

      block.call

      self.top_binding = previous_top_binding

      body = Fragment.new code: fragments[bin].map(&:code).join("\n")
      fragments.delete bin

      body
    end
  end
end
