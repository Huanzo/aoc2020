input = File.readlines('./input')

a = input.map do |pwl|
  matches = pwl.match /(?<start>\d+)-(?<end>\d+) (?<char>\w): (?<pw>\w+)/
  matches[:pw].count(matches[:char]).between? matches[:start].to_i, matches[:end].to_i
end
puts a.count(true)

