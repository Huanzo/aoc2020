# frozen_string_literal: true

input = File.read('./input').split("\n\n")

required = %w[byr iyr eyr hgt hcl ecl pid]

out = input.map do |passport|
  required.count { |e| passport.include? e } == required.size
end
puts out.count(true)
