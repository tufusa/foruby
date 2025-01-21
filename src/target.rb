# frozen-string-literal: true

require './lib/foruby'

using Foruby
Foruby::Core.top_binding = binding
Foruby::Tracer.trace binding

a = integer.set
b = integer.parameter.set(1)

puts 'Hello, world!'
puts ((1 + 1 * 4 - 2).abs + -8.abs / 2).abs / 3
puts a
puts b

c = 1
d = integer.set(2)
a = b + c + d

puts a
puts b

sum = integer.set(0)
(1..2).each do |i|
  puts i
  sum += i
end

puts sum

double = function(
  {
    num: integer,
    n2: integer,
    n3: integer
  },
  integer
) do |num, n2, n3|
  a += num
  result(num * 2)
end

say = function(
  {
    num: integer
  }
) do |num|
  puts num
end

say[double[100, 1, 2]]

puts a
