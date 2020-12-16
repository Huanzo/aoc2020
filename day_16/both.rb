input = File.read('./input').split("\n\n")

$rules = input[0].lines.map do |rule|
  _, name, s1, e1, s2, e2 = *rule.match(/(.*): (\d+)-(\d+) or (\d+)-(\d+)/)
  { name => [(Integer(s1)..Integer(e1)), (Integer(s2)..Integer(e2))] }
end.inject :merge

$my_ticket = input[1].lines.last.split(',').map(&:to_i)

$other_tickets = input[2].lines.drop(1).map(&:chomp).map { |s| s.split(',').map(&:to_i) }

def valid?(value)
  t = $rules.values.map do |r1, r2|
    r1.include?(value) || r2.include?(value)
  end
  t.include? true
end

def invalid_values(ticket)
  ticket.select do |value|
    !valid?(value)
  end
end

def invalid_in(value)
  invaluid_rules = []
  $rules.each do |name, ranges|
    e1 = ranges[0].include? value
    e2 = ranges[1].include? value
    invaluid_rules << name unless e1 || e2
  end
  invaluid_rules
end

out = []

$valid_tickets = $other_tickets.select do |ticket|
  values = invalid_values(ticket)
  out.push(*values)
  values.empty?
end

puts out.inject(:+)

$map = $my_ticket.map do |_|
  $rules.keys
end

$valid_tickets.each do |ticket|
  ticket.each_with_index do |value, i|
    impossible = invalid_in(value)
    $map[i] = $map[i] - impossible
  end
end

map = []

$my_ticket.size.times do |i|
  fixed = $map.find { |e| e.size == i + 1 }
  idx = $map.index(fixed)
  map[idx] = (fixed - map.flatten)
end

map.flatten!

res = []
map.each_with_index do |e, i|
  next unless e.start_with? 'departure'

  res << $my_ticket[i]
end

puts res.inject :*
