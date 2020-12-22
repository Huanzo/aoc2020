input = File.read('./input').split("\n\n").map { |l| l.split("\n") }

p1 = input[0].drop(1).map(&:to_i)
p2 = input[1].drop(1).map(&:to_i)

def play_game(deck1, deck2)
  history = {}

  until deck1.empty? || deck2.empty?
    return true if history[deck1] && history[deck2]

    history[deck1] = true
    history[deck2] = true
    p1 = deck1.shift
    p2 = deck2.shift

    round_winner = if p1 <= deck1.size && p2 <= deck2.size
                     play_game(deck1[0, p1], deck2[0, p2])
                   else
                     p1 > p2
                   end
    round_winner ? deck1.push(p1, p2) : deck2.push(p2, p1)
  end
  winner = deck1.empty? ? deck2 : deck1
  deck1.size > deck2.size
end

winner = play_game(p1, p2) ? p1 : p2
puts (1..winner.size).reverse_each.zip(winner).map { |l, r| l * r }.sum
