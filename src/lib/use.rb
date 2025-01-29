# frozen-string-literal: true

require_relative 'foruby'

module Foruby
  # Extension for use
  module UseExtension
    def use(module_name, aliases = nil, only: nil)
      raise ArgumentError, 'Either aliases or only can be used' if aliases && only

      attribute =
        if aliases
          aliases.map { |prev, new| "#{new} => #{prev}" }.join ','
        elsif only.is_a? String
          "only: #{only}"
        elsif only.is_a?(Array) || only.is_a?(Hash)
          statement = only.map do |data|
            case data
            when String then data
            when Hash then data.map { |prev, new| "#{new} => #{prev}" }.join ','
            end
          end.join ','
          "only: #{statement}"
        end

      Core.add_use "use #{module_name}#{attribute && ', '}#{attribute}"

      nil
    end
  end
end
