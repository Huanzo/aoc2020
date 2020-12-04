# frozen_string_literal: true

input = File.read('./input').split("\n\n")

required = %w[byr iyr eyr hgt hcl ecl pid]

def valid?(key, value)
  case key
  when 'byr'
    value.to_i.between? 1920, 2002
  when 'iyr'
    value.to_i.between? 2010, 2020
  when 'eyr'
    value.to_i.between? 2020, 2030
  when 'hgt'
    _, num, unit = *value.match(/(\d+)(.+)/)
    case unit
    when 'cm'
      num.to_i.between? 150, 193
    when 'in'
      num.to_i.between? 59, 76
    end
  when 'hcl'
    !!value[/\A#[0-9a-f]{6}\z/]
  when 'ecl'
    %w[amb blu brn gry grn hzl oth].include? value
  when 'pid'
    !!value[/\A[0-9]{9}\z/]
  end
end

out = input.map do |passport|
  values = passport.split /[\s|\n]/
  
  required.map do |key|
    key, value = values.find{|v| v.start_with? key}&.split ':'
    valid?(key, value)
  end.inject(:&)
end
puts out.count(true)
