# frozen_string_literal: true

input = File.readlines('./input')

$earliest = Integer(input.first)
$ids = input[1].split(',')
$ids.delete 'x'
$ids = $ids.map(&:to_i)

out = $ids.map do |id|
  b = $earliest / id
  nearest = b * id
  nearest < $earliest ? nearest + id : nearest
end

busid = $ids[out.index(out.min)]

puts busid * (out.min - $earliest)
