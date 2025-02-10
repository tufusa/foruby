# frozen-string-literal: true

require './lib/foruby'

f = Foruby.init binding

# use 'gtool_history'
# use 'dc_types', only: 'DP'

inline = true

im = integer.parameter.set 128
g_zeta = real.dimension(0...im).set
g_zeta0 = real.dimension(0...im).set
g_zeta1 = real.dimension(0...im).set

xmin = real.parameter.set 0.0
xmax = real.parameter.set 3.0
xl = real.parameter.set xmax - xmin

dt = real.parameter.set 1e-6
nt = integer.parameter.set 50_000_000
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

# output_gtool_init = function({}) do
#   f.eval <<~CODE
#     call HistoryCreate( &
#       file='kdv1.nc', title='KDV equation model (Leap frog)',  &
#       source='Sample program of SPMODEL/KdV equation',         &
#       institution='GFD_Dennou Club: SPMODEL Projectt',         &
#       dims=(/'x','t'/), dimsizes=(/#{im},0/),                  &
#       longnames=(/'X-coordinate','time        '/),             &
#       units=(/'1','1'/),                                       &
#       origin=0.0, interval=real(#{ndisp * dt}) )

#     call HistoryPut('x',#{g_x})
#     call HistoryAddattr('x','topology','circular')
#     call HistoryAddattr('x','modulo',#{xl})

#     call HistoryAddVariable( &
#       varname='zeta', dims=(/'x','t'/), &
#       longname='displacement', units='1', xtype='double')
#   CODE
# end

# output_gtool = function(
#   {
#     it: integer
#   }
# ) do |it|
#   puts 'it = ', it
#   f.eval "call HistoryPut('t', #{it * dt})"
#   f.eval "call HistoryPut('zeta', #{g_zeta})"
# end

# output_gtool_close = function({}) do
#   f.eval 'call HistoryClose'
# end

sqrt = lambda do |x|
  Foruby::RealFragment.new "sqrt(#{x})"
end

g_zeta = sech[(g_x - x1) / sqrt[12 / u1]]**2 * u1 +
         sech[(g_x - x2) / sqrt[12 / u2]]**2 * u2

g_zeta0 = g_zeta
g_zeta1 = g_zeta

# output_gtool_init[]
# output_gtool[0]

(1..nt).each do |j|
  g_zeta = g_zeta0 + 2 * dt * (-g_zeta1 * dx1[g_zeta1] - dx3[g_zeta1])

  g_zeta0 = g_zeta1
  g_zeta1 = g_zeta

  f.if (j % ndisp).zero? do
    puts 'it = ', j
    # output_gtool[j]
  end
end

# output_gtool_close[]
