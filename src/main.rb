# frozen-string-literal: true

require './src/target'

code = Foruby::Core.fragments.map(&:code).join("\n")
program = <<~"PROGRAM"
  program main
  #{code}
  endprogram main
PROGRAM

file = './out/main.f90'

File.write file, program
`fprettify #{file} --indent 2`

formatted_program = File.read file
puts <<~"OUTPUT"
  =====OUTPUT=====
  #{formatted_program.chomp}
  ================\n
OUTPUT

`gfortran out/main.f90 -o ./out/main.out`
res = `./out/main.out`

puts <<~"RESULT"
  =====RESULT=====
  #{res.chomp}
  ================
RESULT
