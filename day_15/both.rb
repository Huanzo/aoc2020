def run(start, target)
  turn = start.size
  number = start.last
  numbers = Array.new(target) { 0 }

  start[0..-2].each_with_index do |value, turn|
    numbers[value] = turn + 1
  end

  (turn..target - 1).each do |turn|
    next_num = numbers[number].eql?(0) ? 0 : turn - numbers[number]

    numbers[number] = turn
    number = next_num
  end
  number
end

input = [19, 0, 5, 1, 10, 13]

puts run input, 2020
puts run input, 30_000_000
