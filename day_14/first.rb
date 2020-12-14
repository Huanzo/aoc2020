# frozen_string_literal: true

input = File.readlines('./input').map(&:strip)
$mask = ''
$mem = {}

def set_mask(mask)
  _, $mask = mask.split(' = ')
end

def apply_mask(num)
  bin = '%036b' % num
  $mask.chars.each_with_index do |bit, i|
    next if bit == 'X'

    bin[i] = bit
  end
  Integer(bin, 2)
end

def run(cmd)
  _, index, val = *cmd.match(/\Amem\[(\d+)\] = (\d+)\z/)
  index = Integer(index)
  val = Integer(val)
  $mem[index] = apply_mask(val)
end

input.each do |line|
  (set_mask(line); next) if line.start_with? 'mask'
  run(line)
end

puts $mem.values.sum
