# frozen-string-literal: true

module Foruby
  module Util
    # Module to make refinement methods alias.
    module MakeAlias
      def make_alias(mod, methods)
        methods.each do |method|
          base_name = method.to_s.delete_prefix('_')
          mod.alias_method :"origin_#{base_name}", :"#{base_name}"
          mod.alias_method :"#{base_name}", method
        end
      end
    end
  end
end
