# frozen_string_literal: true

target :lib do
  collection_config 'rbs_collection.yaml'

  check 'src/**/*.rb'
  check 'sample/**/*.rb'
  ignore 'src/**/*.test.rb'

  signature 'src/sig/**/*.rbs'
  ignore_signature 'src/sig/minitest/**/*.rbs'

  configure_code_diagnostics(Steep::Diagnostic::Ruby.all_error)
end

target :test do
  collection_config 'rbs_collection.yaml'

  check 'src/**/*.test.rb'

  signature 'src/sig/minitest/**/*.rbs'

  configure_code_diagnostics(Steep::Diagnostic::Ruby.all_error)

  library 'minitest'
end
