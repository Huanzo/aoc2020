# frozen_string_literal: true

input = File.readlines('./input').map do |line|
  [line[0], Integer(line[1..-1])]
end

$position = [0, 0]
$waypoint = [10, 1]

def rad(deg)
  deg * Math::PI / 180
end

def rotate(deg)
  x,y = $waypoint
  rad = rad(deg)
  $waypoint[0] = (x*Math.cos(rad) - y*Math.sin(rad)).round
  $waypoint[1] = (x*Math.sin(rad) + y*Math.cos(rad)).round
end

def move(action, value)
  case action
  when 'N'
    $waypoint[1] += value
  when 'S'
    $waypoint[1] -= value
  when 'E'
    $waypoint[0] += value
  when 'W'
    $waypoint[0] -= value
  when 'L'
    rotate(value)
  when 'R'
    rotate(-value)
  when 'F'
    $position[0] += $waypoint[0] * value
    $position[1] += $waypoint[1] * value
  end
end

input.each do |instr|
  move(*instr)
end

puts $position.values_at(0, 1).map(&:abs).sum
