# frozen_string_literal: true

input = File.readlines('./input')

$ids = input[1].split(',')
$ids = $ids.map(&:to_i)

$first = 0
$period = 1

$ids.each_with_index do |bus_period, id|
  next if bus_period == 0

  0.step do |i|
    cand = $first + $period * i
    if (cand + id) % bus_period == 0
      $first = cand
      $period = $period.lcm bus_period
      break
    end
  end
end

puts $first
