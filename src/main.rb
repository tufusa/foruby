# frozen-string-literal: true

require 'open3'
require 'optparse'
require_relative 'lib/foruby'

opt = OptionParser.new do
  _1.banner = 'usage: main.rb [options] [filename]'

  _1.on '-i FILENAME', '--in=FILENAME', 'Input filename'
  _1.on '-o FILENAME', '--out=FILENAME', 'Output filename'
  _1.on '-c', '--compile', 'Compile automatically'
  _1.on '-e', '--execute', 'Execute automatically (work only with `--compile`)'
  _1.on '--outdir=DIRNAME', 'Output directory (overwitten by `--out`)'
end

params = Hash.new nil # : Hash[Symbol, String?]
opt.parse! ARGV, into: params

input = params[:in] || ARGV.shift # : String?
output = params[:out]
raise ArgumentError, 'No input filename' if input.nil?

puts '[generate]'

input = File.absolute_path input
require_relative input

output = File.absolute_path output || "#{params[:outdir]&.+ '/'}#{File.basename input, '.rb'}.f90"

top = Foruby::Core.scopes[Foruby::Core.top_binding]

uses = top.uses.map(&:code).join("\n")
variables = top.variables.map(&:code).reject { _1 == '' }.join("\n")
fragments = top.fragments.map(&:code).reject { _1 == '' }.join("\n").split("\n")
functions = top.functions.map(&:code).reject { _1 == '' }.join("\n\n")

body = fragments.map do |line| # $ String
  next line if line.size <= 100

  lines = (line.size / 100.0).ceil
  whitespaces = line.chars.map.with_index { [_1, _2] }.filter { _1[0] == ' ' }.map(&:last)
  raise NotImplementedError, 'Cannot handle for no whitespace' if whitespaces.empty?

  (0...lines).map do |i|
    from = i.zero? ? 0 : whitespaces[whitespaces.size / lines * i]
    to = i == lines - 1 ? line.size : whitespaces[whitespaces.size / lines * (i + 1)]
    line.slice from...to
  end.join(" &\n& ")
end.join "\n"

contains = functions.empty? ? '' : <<~CONTAINS.chomp
  contains
    #{functions}
CONTAINS

program = <<~PROGRAM
  program main
    #{uses}
    implicit none
    #{variables}

    #{body}
  #{contains}
  end program main
PROGRAM

File.write output, program
`fprettify #{output} --indent 2`

formatted_program = File.read output
puts <<~OUTPUT
  #{formatted_program.chomp}\n
OUTPUT

exit unless params[:compile]

puts '[compile]'

binary = "#{File.dirname output}/#{File.basename output, '.*'}.out"
compile = "gfortran #{output} -o #{binary} #{ARGV.join ' '}"

puts compile
puts `#{compile}`

exit unless $?&.success?

exit unless params[:execute]

puts '[execute]'

Open3.popen3(binary) do |_in, out, err| # steep:ignore NoMethod
  # @type var out: IO
  # @type var err: IO
  out.each { print _1 }
  err.each { print _1 }
end
