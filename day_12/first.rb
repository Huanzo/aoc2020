# frozen_string_literal: true

input = File.readlines('./input').map do |line|
  [line[0], Integer(line[1..-1])]
end

DIRS = { 0 => 'N', 1 => 'E', 2 => 'S', 3 => 'W' }.freeze

$position = [0, 0, 90]

def move(action, value)
  case action
  when 'N'
    $position[1] += value
  when 'S'
    $position[1] -= value
  when 'E'
    $position[0] += value
  when 'W'
    $position[0] -= value
  when 'L'
    $position[2] -= value
  when 'R'
    $position[2] += value
  when 'F'
    move(DIRS[$position[2] / 90 % 4], value)
  end
end

input.each do |instr|
  move(*instr)
end

puts $position.values_at(0, 1).map(&:abs).sum
