input = File.readlines('./input').map(&:strip).map(&:chars)

$dirs = [
  [-1,-1],
  [-1,0],
  [-1,1],
  [0,-1],
  [0,1],
  [1,-1],
  [1,0],
  [1,1]
]


def round(map)
  output = []
  map.each_index do |row|
    output << []
    map[row].each_index do |col|
      tmp = $dirs.map do |x, y|
        x_index = row + x
        y_index = col + y

        char = loop do
          break nil if x_index < 0 || y_index < 0 || x_index >= map.size || y_index >= map[row].size
          char = map[x_index]&.[](y_index)
          x_index += x
          y_index += y
          next if char == '.'
          break char
        end

        char
      end
      occupied = tmp.compact.count('#')
      output[row][col] = case [map[row][col], occupied]
      in ['L', 0]
        '#'
      in ['#', 5..]
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
