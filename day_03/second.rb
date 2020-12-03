# frozen_string_literal: true

input = File.readlines './input'
width = input.first.strip.size
output = []

[
  { r: 1, d: 1 },
  { r: 3, d: 1 },
  { r: 5, d: 1 },
  { r: 7, d: 1 },
  { r: 1, d: 2 }
].each do |dir|
  count = 0
  input.each_with_index.select do |_, i|
    i % dir[:d] == 0
  end.each_with_index do |row, i|
    count += 1 if row.first[i * dir[:r] % width] == '#'
  end
  output << count
end

puts output.inject :*
