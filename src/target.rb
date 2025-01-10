# frozen-string-literal: true

require './lib/foruby'
require './lib/tracer'

using Foruby
Foruby::Tracer.trace binding

c = -1
a = integer(10)
b = integer(1).parameter

puts 'Hello, world!'
puts ((1 + 1 * 4 - 2).abs + -8.abs / 2).abs / 3
puts a
puts b

a = c
a = b

puts a
puts b
