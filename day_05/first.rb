# frozen_string_literal: true

input = File.readlines('./input')

output = input.map do |row|
  Integer(row.tr('FBLR', '0101'), 2)
end

puts output.max
