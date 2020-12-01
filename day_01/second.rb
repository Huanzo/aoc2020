# frozen_string_literal: true

input = File.read('./input').lines.map(&:to_i)

input.each do |i|
  input.each do |j|
    next if i + j > 2020
    rem = 2020 - i - j

    if input.include? rem
      puts i * j * rem 
      return
    end
  end
end
