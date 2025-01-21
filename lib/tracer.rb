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

            if old_value.nil? && new_value.is_a?(Fragment) &&
               !new_value.builder.nil? && new_value.variable.nil? # new declaration
              Core.add_variable name, new_value.builder

              new_value.variable = Variable.new name, new_value
              bin.local_variable_set name, new_value
            elsif old_value.nil? && (new_value.is_a?(Function) || new_value.is_a?(VoidFunction)) # new method definition
              new_value.name = name
              Core.top_binding.receiver.define_singleton_method(name) { |*params| new_value[*params] }
              Core.add_function new_value
            elsif old_value.is_a?(Fragment) && !old_value.variable.nil? # assign
              Core.check new_value
              Core.push old_value.variable.assignment(new_value.inspect)

              old_value.variable.value = new_value
              new_value = old_value
              bin.local_variable_set name, new_value
            end
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
