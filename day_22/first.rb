input = File.read('./input').split("\n\n").map { |l| l.split("\n") }

$p1 = input[0].drop(1).map(&:to_i)
$p2 = input[1].drop(1).map(&:to_i)

until $p1.empty? || $p2.empty?
  p1 = $p1.shift
  p2 = $p2.shift

  p1 > p2 ? $p1.push(p1, p2) : $p2.push(p2, p1)
end

$winner = $p1.empty? ? $p2 : $p1

puts (1..$winner.size).reverse_each.zip($winner).map { |l, r| l * r }.sum
