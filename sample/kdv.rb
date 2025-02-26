# frozen-string-literal: true

f = Foruby.init binding

inline = true

im = integer.parameter.set 128
g_zeta = real.dimension(0...im).set
g_zeta0 = real.dimension(0...im).set
g_zeta1 = real.dimension(0...im).set

xmin = real.parameter.set 0.0
xmax = real.parameter.set 3.0
xl = real.parameter.set xmax - xmin

dt = real.parameter.set 1e-9
nt = integer.parameter.set 5_000_000
ndisp = integer.parameter.set nt / 50

x1 = real.parameter.set (xmax + xmin) * 5e-1
u1 = real.parameter.set 7.20e2
x2 = real.parameter.set (xmax + 3 * xmin) * 2.5e-1
u2 = real.parameter.set 1.44e3

dx = real.parameter.set xl / im

g_x = real.dimension(0...im).set

(0...im).each do |i|
  f.eval "g_x(#{i}) = #{xmin + xl / im * i}"
end

sech = function(
  {
    x: real.dimension(0...im)
  },
  real.dimension(0...im),
  inline:
) { |x| result(2.0 / (exp(x) + exp(-x))) }

dx1 = function(
  { g: real.dimension(0...im) }, real.dimension(0...im),
  inline:
) do |g|
  result (cshift(g, 1) - cshift(g, -1)) / (2 * dx)
end

dx3 = function(
  { g: real.dimension(0...im) }, real.dimension(0...im),
  inline:
) do |g|
  result (cshift(g, 2) - 2 * cshift(g, 1) + 2 * cshift(g, -1) - cshift(g, -2)) / (2 * dx**3)
end

sqrt = ->(x) { Foruby::RealFragment.new "sqrt(#{x})" }

g_zeta = sech[(g_x - x1) / sqrt[12 / u1]]**2 * u1 +
         sech[(g_x - x2) / sqrt[12 / u2]]**2 * u2

g_zeta0 = g_zeta
g_zeta1 = g_zeta

(1..nt).each do |j|
  g_zeta = g_zeta0 + 2 * dt * (-g_zeta1 * dx1[g_zeta1] - dx3[g_zeta1])

  g_zeta0 = g_zeta1
  g_zeta1 = g_zeta

  f.if (j % ndisp).zero? do
    puts 'it = ', j
  end
end
