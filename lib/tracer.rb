# frozen_string_literal: true

require_relative 'variable'

module Foruby
  # Trace to variable declaration or assignment
  module Tracer
    class << self
      def trace(bin)
        variables = bin.local_variables
        values = get_values variables, bin

        TracePoint.trace :line do
          current_values = get_values variables, bin

          new_values = variables.map.with_index do |name, i|
            old_value = values[i]
            new_value = current_values[i]
            is_changed = old_value != new_value

            next new_value unless is_changed

            if old_value.nil? && new_value.is_a?(Builder) # new declaration
              Core.push new_value.declaration(name.to_s)

              variable = Variable.new name, new_value.build
              new_value = variable
              bin.local_variable_set name, new_value
            elsif old_value.is_a?(Variable) # assign
              Core.push old_value.assignment(new_value.inspect)

              old_value.value = new_value
              new_value = old_value
              bin.local_variable_set name, new_value
            end

            puts "assign: #{name} <- #{new_value.value}" if new_value.is_a?(Variable)
            new_value
          end

          values = new_values
        end
      end

      private

      def get_values(variables, bin) = variables.map { bin.local_variable_get _1 }
    end
  end
end
