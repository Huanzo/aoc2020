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
    next if bit == '0'

    bin[i] = bit
  end
  bin
end

def get_indices(index)
  return [index] if index.count('X') == 0

  idx = index.index 'X'
  left = index
  right = left.dup
  left[idx] = '0'
  right[idx] = '1'
  [*get_indices(left), *get_indices(right)]
end

def run(cmd)
  _, index, val = *cmd.match(/\Amem\[(\d+)\] = (\d+)\z/)
  index = Integer(index)
  val = Integer(val)

  index = apply_mask(index)
  indices = get_indices(index)
  indices.each do |idx|
    $mem[idx] = val
  end
end

input.each do |line|
  (set_mask(line); next) if line.start_with? 'mask'
  run(line)
end

puts $mem.values.sum
