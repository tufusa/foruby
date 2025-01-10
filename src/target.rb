# frozen-string-literal: true

require './lib/foruby'

using Foruby
Foruby::Tracer.trace binding

c = 1
a = integer.set
b = integer.parameter.set(1)

puts 'Hello, world!'
puts ((1 + 1 * 4 - 2).abs + -8.abs / 2).abs / 3
puts a
puts b

a = b + c

puts a
puts b
