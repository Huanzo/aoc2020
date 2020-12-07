input = File.readlines('./input')

map = input.map do |line|
  bag = line[/\A(\w+\s\w+)/]
  contains = line.scan(/\d\s(\w+\s\w+)/).flatten
  Hash[bag, contains]
end.inject :merge

@count = 0
@visited = []
@counted_bags = []

def find_combinations(map, bag_color)
  submap = map.select do |k,v|
    k if v.include?(bag_color) && !@counted_bags.include?(k)
  end
  @count += submap.count
  @counted_bags.push *submap.keys

  (submap.keys - @visited).each do |color|
    @visited << color
    find_combinations(map, color)
  end
end

find_combinations(map, 'shiny gold')
puts @count 
