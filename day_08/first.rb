# frozen_string_literal: true

input = File.readlines('./input').map(&:split)

acc = 0
pc = 0
visited = []

until visited.include? pc
  instr, val = *input[pc]
  visited << pc
  case instr
  when 'nop'
    pc += 1
    next
  when 'acc'
    acc += Integer(val)
  when 'jmp'
    pc += Integer(val)
    next
  end
  pc += 1
end

puts acc
