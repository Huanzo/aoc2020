# frozen_string_literal: true

d_pub = 17_607_508
c_pub = 15_065_270
modulo = 20_201_227

subject_mum = 7
val = 1

0.step do |i|
  (puts(c_pub.pow(i, modulo)); break) if val == d_pub
  val *= subject_mum
  val %= modulo
end
