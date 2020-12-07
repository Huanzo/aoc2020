# frozen_string_literal: true

input = File.readlines('./input')

map = input.map do |line|
  bag = line[/\A(\w+\s\w+)/]
  contains = line.scan(/(\d\s\w+\s\w+)/).flatten
  Hash[bag, contains]
end.inject :merge

def count_bags(map, bag_color)
  _, bags = map.find { |key, _| key.include? bag_color }
  counts = bags.map do |bag|
    _, mul, col = *bag.match(/(\d+) (\w+ \w+)/)
    mul.to_i != 0 ? mul.to_i * count_bags(map, col) : 0
  end

  1 + (counts.inject(:+) || 0)
end

puts count_bags(map, 'shiny gold') - 1
