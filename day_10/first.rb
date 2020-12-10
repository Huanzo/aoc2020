# frozen_string_literal: true

input = File.readlines('./input').map(&:to_i).sort

$d = { 1 => 0, 2 => 0, 3 => 0 }
$j = 0
input << input.max + 3

input.each do |adapter|
  diff = adapter - $j
  if diff.between? 1, 3
    $d[diff] += 1
    $j = adapter
  end
end

puts $d[1] * $d[3]
