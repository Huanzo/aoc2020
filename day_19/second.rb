# frozen_string_literal: true

input = File.read('./input').split("\n\n").map { |r| r.split("\n") }

# Replacements for Part 2
input[0].delete('8: 42')
input[0].push('8: 42 | 42 8')
input[0].delete('11: 42 31')
input[0].push('11: 42 31 | 42 11 31')

$mem = {}
$lines = input[1]

$rules = input[0].map do |i|
  k, v = i.match(/(\d+): (.*)/).captures
  [k, v.split('|').map do |x|
    x.split(' ').reject(&:empty?).compact.map do |y|
      y.gsub('"', '')
    end
  end]
end.sort_by(&:first).to_h

def rules(key, d = 0)
  $mem[key] ||= begin
    either_or = $rules[key]

    d += 1
    return '' if d == 96
    return key unless either_or

    pair = either_or.map do |group|
      group.map do |sub_rule|
        rules(sub_rule, d)
      end.join('')
    end.join('|')
    if pair.include?('|')
      '(?:' + pair + ')'
    else
      pair
    end
  end
end

re = Regexp.new('^' + rules('0') + '$')

puts $lines.select { |line| re.match(line) }.size
