# frozen-string-literal: true

require './lib/foruby'

using Foruby
Foruby::Core.top_binding = binding
Foruby::Tracer.trace binding

a = integer.set
b = integer.parameter.set(1)
c = 1

# TODO: ループ用変数を自動で宣言する
i = integer.set
sum = integer.set(0)

puts 'Hello, world!'
puts ((1 + 1 * 4 - 2).abs + -8.abs / 2).abs / 3
puts a
puts b

a = b + c

puts a
puts b

(1..10).each do |i|
  puts i
  sum += i
end

puts sum
