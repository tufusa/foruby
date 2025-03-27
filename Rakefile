# frozen-string-literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'src/lib/**/*.test.rb'
end

task :typecheck do
  sh 'bundle exec steep check'
end
