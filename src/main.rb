# frozen-string-literal: true

require './src/target'

top = Foruby::Core.scopes[Foruby::Core.top_binding]

uses = top.uses.map(&:code).join("\n")
variables = top.variables.map(&:code).join("\n")
body = top.fragments.map(&:code).join("\n")
functions = top.functions.map(&:code).join("\n\n")

program = <<~"PROGRAM"
  program main
    #{uses}

    implicit none

    #{variables}

    #{body}
  contains
    #{functions}
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
