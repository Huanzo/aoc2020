# frozen_string_literal: true

input = File.read('./input').split("\n\n").map { |r| r.split("\n") }

$mem = {}
$lines = input[1]

$rules = input.first.map do |i|
  k, v = i.match(/(\d+): (.*)/).captures
  [k, v.split('|').map do |x|
    x.split(' ').reject(&:empty?).compact.map do |y|
      y.gsub('"', '')
    end
  end]
end.sort_by(&:first).to_h

def rules(key)
  $mem[key] ||= begin
    either_or = $rules[key]

    return key unless either_or

    pair = either_or.map do |group|
      group.map do |sub_rule|
        rules(sub_rule)
      end.join('')
    end.join('|')
    if pair.include?('|')
      '(' + pair + ')'
    else
      pair
    end
  end
end

re = Regexp.new('^' + rules('0') + '$')

puts $lines.select { |line| re.match(line) }.size
