# frozen_string_literal: true

input = File.readlines('./input').map(&:strip).map(&:chars)

$dirs = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
]

def round(map)
  output = []
  map.each_index do |row|
    output << []
    map[row].each_index do |col|
      tmp = $dirs.map do |x, y|
        x_index = row + x
        y_index = col + y

        next nil if x_index.negative? || y_index.negative?

        map[row + x]&.[](col + y)
      end
      occupied = tmp.compact.count('#')
      output[row][col] = case [map[row][col], occupied]
      in ['L', 0]
        '#'
      in ['#', 4..]
        'L'
      else
        map[row][col]
      end
    end
  end

  output
end

last_hash = 0
out = input

until out.hash == last_hash
  last_hash = out.hash
  out = round out
end

puts out.map{_1.count('#')}.inject(:+)
