# frozen_string_literal: true

target :lib do
  check 'src/**/*.rb'
  check 'sample/**/*.rb'
  signature 'src/sig/**/*.rbs'

  configure_code_diagnostics(Steep::Diagnostic::Ruby.all_error)
end
