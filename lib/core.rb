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
      @@fragments.pop if code.is_a? Fragment
    end

    def self.push(code)
      @@fragments << Fragment.new(code:)
    end
  end
end
