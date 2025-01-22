# frozen_string_literal: true

require_relative 'foruby'

module Foruby
  # If statement wrapper
  class IfBuilder
    def initialize(condition, &action)
      Core.check condition
      @branches = [{ condition:, action: }]
      push_build
    end

    def else_if(condition, &action)
      Core.check condition
      @branches << { condition:, action: }
      push_build
      self
    end

    def else(&action)
      @else_action = action
      push_build
      nil
    end

    private

    def push_build
      @latest_pushed&.then { Core.check _1 }
      @latest_pushed = Core.push build
    end

    def build
      raise RangeError, 'No branch to be built' if @branches.empty?

      Fragment.new code: <<~CODE
        #{if_statement}
        #{else_if_statement || ''}
        #{else_statement || ''}
        #{end_if_statement}
      CODE
    end

    def if_statement
      branch = @branches[0]
      condition = branch[:condition]
      action = branch[:action]
      body = Core.add_block(action.binding, &action).fragments.map(&:code).join("\n")
      <<~IF
        if (#{condition}) then
          #{body}
      IF
        .chomp
    end

    def else_if_statement
      @branches[1..]&.map do |branch|
        condition = branch[:condition]
        action = branch[:action]

        body = Core.add_block(action.binding, &action).fragments.map(&:code).join("\n")
        <<~ELSE_IF
          else if (#{condition}) then
            #{body}
        ELSE_IF
          .chomp
      end&.join("\n")
    end

    def else_statement
      @else_action&.then do |action|
        body = Core.add_block(action.binding, &action).fragments.map(&:code).join("\n")
        <<~ELSE
          else
            #{body}
        ELSE
          .chomp
      end
    end

    def end_if_statement = 'end if'
  end
end
