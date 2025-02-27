# foruby

## Example

```bash
ruby src/main.rb --compile --execute --outdir=out collatz.rb
```

input: `collatz.rb`
```ruby
f = Foruby.init binding

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
```

output: `out/collatz.f90`
```f90
program main

  implicit none
  integer :: step = 1
  integer :: val = 27

  print *, step, ":", val
  do
    val = collatz(val)
    step = (step + 1)
    print *, step, ":", val
    if (val == 1) then
      exit

    end if
  end do
contains
  function collatz(x) result(ret_collatz)

    implicit none

    integer :: x

    integer :: ret_collatz

    if (mod(x, 2) == 0) then
      ret_collatz = (x/2)
      return

    else
      ret_collatz = ((3*x) + 1)
      return

    end if
  end function collatz
end program main
```
