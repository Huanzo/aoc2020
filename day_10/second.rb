# frozen_string_literal: true

input = File.readlines('./input').map(&:to_i).sort

input << input.max + 3

$c = { 0 => 1 }

input.each do |e|
  $c[e] = $c.values_at(e - 1, e - 2, e - 3).compact.sum
end
puts $c[input.last]
