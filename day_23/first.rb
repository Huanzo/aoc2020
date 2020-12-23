def game(cups, moves)
  idx = 0

  moves.times do |i|
    cycle = 0
    pickup = begin
      p = cups.slice!(idx + 1, 3)
      cycle = 3 - p.size
      p += cups.slice!(0, 3 - p.size) if p.size < 3
      p
    end

    prev_cup = cups[idx - cycle]
    curr_cup = if idx < cups.size
                 cups[idx]
               else
                 cups[idx - cycle]
               end

    dest_idx = begin
      tmp = 1
      loop do
        if pickup.include?(curr_cup - tmp)
          tmp += 1
        elsif cups.min > (curr_cup - tmp)
          break cups.index(cups.max)
        else
          break cups.index(curr_cup - tmp)
        end
      end
    end

    cups.insert(dest_idx + 1, *pickup)
    cups.push(cups.shift) while cups[idx] != prev_cup

    idx = (idx + 1) % cups.size
  end
  cups.push(cups.shift) until cups.first == 1
  cups.drop(1).join
end

input = [5, 6, 2, 8, 9, 3, 1, 4, 7]

puts game(input, 100)
