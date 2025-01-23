# frozen-string-literal: true

module Foruby
  module Util
    # Module to make refinement methods alias.
    module MakeAlias
      def make_alias(mod, methods)
        methods.each do |method|
          base_name = method.to_s.delete_prefix('_')
          name = method_name base_name.to_sym
          mod.alias_method :"origin_#{name}", :"#{name}"
          mod.alias_method :"#{name}", method
        end
      end

      private

      def method_name(source)
        METHOD_MAP.fetch source, source
      end

      METHOD_MAP = {
        plus: :+,
        minus: :-,
        multiple: :*,
        divide: :/,
        equal: :==,
        not: :!,
        and: :&,
        or: :|,
        xor: :^,
        not_equal: :!=
      }.freeze
    end
  end
end
