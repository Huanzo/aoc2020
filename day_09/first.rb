# frozen_string_literal: true

input = File.readlines('./input').map(&:to_i)
preamble = 25

input.each_with_index do |_line, i|
  next if i < preamble

  unless input[i - preamble, preamble].combination(2).find { |a, b| a + b == input[i] }
    puts input[i]
    return
  end
end
