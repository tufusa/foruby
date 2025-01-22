# frozen-string-literal: true

require './lib/foruby'

f = Foruby.init binding

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
    num: integer
  },
  integer
) do |num|
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

say[double[100]]

puts a

f.if a == 1 do
  puts 'a is 1'
end.else_if a == 2 do
  puts 'a is 2'
end.else do
  puts 'idk'
end
