input = File.readlines('./input')

a = input.map do |pwl|
  matches = pwl.match /(?<start>\d+)-(?<end>\d+) (?<char>\w): (?<pw>\w+)/
  matches[:pw].chars.values_at(matches[:start].to_i-1, matches[:end].to_i-1).count(matches[:char])
end
puts a.inspect
puts a.count(1)

