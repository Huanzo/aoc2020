input = File.read('./input').split("\n\n")

puts input.map{|g|g.split("\n").join.chars.uniq.count}.sum
