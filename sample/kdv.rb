# frozen-string-literal: true

require './lib/foruby'
f = Foruby.init binding

size = integer.parameter.set 1024
arr = real.dimension(0...size).set(0)
time = integer.parameter.set 10_000_000
ndisp = time / 50

inline = false

double = function(
  {
    x: real.dimension(0...size)
  },
  real.dimension(0...size),
  inline:
) { |x| result x * 2 }

half = function(
  {
    x: real.dimension(0...size)
  },
  real.dimension(0...size),
  inline:
) { |x| result x / 2 }

add_one = function(
  {
    x: real.dimension(0...size)
  },
  real.dimension(0...size),
  inline:
) { |x| result x + 1 }

(1..time).each do |i|
  arr = half[add_one[double[arr]]]

  f.if (i % ndisp).zero? do
    puts 'i = ', i
  end
end
