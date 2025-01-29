f = Foruby.init binding # Forubyの初期化

step = integer.set 1
val = integer.set 27

collatz = function({ x: integer }, integer) do |x|
  f.if x.even? do
    result x / 2
  end.else do
    result 3 * x + 1
  end
end

puts step, ':', val

loop do
  val = collatz[val]
  step += 1
  puts step, ':', val
  f.if(val == 1) { f.eval('exit') }
end
