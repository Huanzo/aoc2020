# frozen_string_literal: true

input = File.readlines('./input').map(&:to_i)
preamble = 25
invalid_num = 21_806_024

input.each_with_index do |_line, i|
  next if i < preamble

  res = []

  range = input[i - preamble, preamble]

  range.each_index do |j|
    res << range[i..-1] if range[i..-1]&.size.to_i > 1
    preamble.times do |k|
      res << range[j, k] if range[j, k]&.size > 1
    end
  end
  out = res.uniq.select { |elems| elems.inject(:+) == invalid_num }
  next if out.empty?

  puts out.flatten.min + out.flatten.max
  break
end
