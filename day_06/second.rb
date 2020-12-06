# frozen_string_literal: true

input = File.read('./input').split("\n\n")

puts input.map { |g| g.split("\n").map(&:chars).inject(:&).join.chars.uniq.count }.sum
