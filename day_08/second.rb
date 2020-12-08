# frozen_string_literal: true

input = File.readlines('./input').map(&:split)

def execute(c)
  pc = acc = 0
  visited = []

  while pc < c.size
    instr = c[pc][0]
    val = Integer(c[pc][1])

    break if visited.include? pc

    visited << pc

    case instr
    when 'acc'
      acc += val
      pc += 1
    when 'jmp'
      pc += val
    when 'nop'
      pc += 1
    end
  end

  [pc, acc]
end

c.each_with_index do |instr, i|
  next if instr[0] == 'acc'

  c[i][0] = instr[0] == 'jmp' ? 'nop' : 'jmp'
  pc, acc = execute(c)
  c[i][0] = instr[0] == 'jmp' ? 'nop' : 'jmp'

  break acc if pc >= c.size
end

puts acc
