# frozen_string_literal: true

input = File.readlines './input'
width = input.first.strip.size
count = 0

input.each_with_index do |row, i|
  next if i == 0

  count += 1 if row[(i * 3) % width] == '#'
end
puts count
