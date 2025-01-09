# frozen_string_literal: true

require_relative 'fragment'

module Foruby
  # Foruby core module
  module Core
    @@fragments = [Fragment.new(code: '')].clear # rubocop:disable Style/ClassVars

    def self.fragments
      @@fragments
    end

    def self.check(code)
      @@fragments.reject! { _1 == code } if code.is_a? Fragment
    end

    def self.push(code)
      fragment = code.is_a?(Fragment) ? code : Fragment.new(code:)
      fragment.tap { @@fragments << _1 }
    end
  end
end
