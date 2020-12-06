input = File.read('./input').split("\n\n")

puts input.map{|g|g.split("\n").map{|e|e.chars}.inject(:&).join.chars.uniq.count}.sum
