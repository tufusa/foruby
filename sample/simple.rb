f = Foruby.init binding

size = integer.parameter.set 1024
array = real.dimension(0...size).set 1
times = 10

transform = function(
  { x: real.dimension(0...size) },
  real.dimension(0...size)
) do |x|
  result x * 3 + 1
end

(0...times).each do |i|
  array = transform[array]
  f.if i.even? do
    puts i, 'is even'
  end
end
