
input = File.read('./input').lines.map(&:to_i)

input.each do |i|
  input.each do |j|
    (puts i*j; return) if i + j == 2020
  end
end
