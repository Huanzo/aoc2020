map = {}

input = File.readlines('./input').map.with_index do |line, i|
  line.chomp.chars.each_with_index { |char, pos| map[[pos, i, 0, 0]] = char }
end

def draw_bounds(map)
  x = map.keys.map { |x, _, _, _| x }
  y = map.keys.map { |_, y, _, _| y }
  z = map.keys.map { |_, _, z, _| z }
  w = map.keys.map { |_, _, _, w| w }

  [x.min - 1, x.max + 1].each do |x|
    (y.min - 1..y.max + 1).each do |y|
      (z.min - 1..z.max + 1).each do |z|
        (w.min - 1..w.max + 1).each do |w|
          map[[x, y, z, w]] = '.'
        end
      end
    end
  end

  [y.min - 1, y.max + 1].each do |y|
    (x.min - 1..x.max + 1).each do |x|
      (z.min - 1..z.max + 1).each do |z|
        (w.min - 1..w.max + 1).each do |w|
          map[[x, y, z, w]] = '.'
        end
      end
    end
  end

  [z.min - 1, z.max + 1].each do |z|
    (y.min - 1..y.max + 1).each do |y|
      (x.min - 1..x.max + 1).each do |x|
        (w.min - 1..w.max + 1).each do |w|
          map[[x, y, z, w]] = '.'
        end
      end
    end
  end

  [w.min - 1, w.max + 1].each do |w|
    (y.min - 1..y.max + 1).each do |y|
      (x.min - 1..x.max + 1).each do |x|
        (z.min - 1..z.max + 1).each do |z|
          map[[x, y, z, w]] = '.'
        end
      end
    end
  end

  map
end

def surrounding_cords(cord)
  x, y, z, w = cord
  cords = [
    [x, y, z, w - 1],
    [x, y, z, w + 1],

    # boottom
    [x, y, z - 1, w],
    [x - 1, y - 1, z - 1, w],
    [x, y - 1, z - 1, w],
    [x + 1, y - 1, z - 1, w],
    [x - 1, y, z - 1, w],
    [x + 1, y, z - 1, w],
    [x - 1, y + 1, z - 1, w],
    [x, y + 1, z - 1, w],
    [x + 1, y + 1, z - 1, w],
    # top
    [x, y, z + 1, w],
    [x - 1, y - 1, z + 1, w],
    [x, y - 1, z + 1, w],
    [x + 1, y - 1, z + 1, w],
    [x - 1, y, z + 1, w],
    [x + 1, y, z + 1, w],
    [x - 1, y + 1, z + 1, w],
    [x, y + 1, z + 1, w],
    [x + 1, y + 1, z + 1, w],
    # middle
    [x - 1, y - 1, z, w],
    [x, y - 1, z, w],
    [x + 1, y - 1, z, w],
    [x - 1, y, z, w],
    [x + 1, y, z, w],
    [x - 1, y + 1, z, w],
    [x, y + 1, z, w],
    [x + 1, y + 1, z, w],

    [x, y, z - 1, w - 1],
    [x - 1, y - 1, z - 1, w - 1],
    [x, y - 1, z - 1, w - 1],
    [x + 1, y - 1, z - 1, w - 1],
    [x - 1, y, z - 1, w - 1],
    [x + 1, y, z - 1, w - 1],
    [x - 1, y + 1, z - 1, w - 1],
    [x, y + 1, z - 1, w - 1],
    [x + 1, y + 1, z - 1, w - 1],
    # top
    [x, y, z + 1, w - 1],
    [x - 1, y - 1, z + 1, w - 1],
    [x, y - 1, z + 1, w - 1],
    [x + 1, y - 1, z + 1, w - 1],
    [x - 1, y, z + 1, w - 1],
    [x + 1, y, z + 1, w - 1],
    [x - 1, y + 1, z + 1, w - 1],
    [x, y + 1, z + 1, w - 1],
    [x + 1, y + 1, z + 1, w - 1],
    # middle
    [x - 1, y - 1, z, w - 1],
    [x, y - 1, z, w - 1],
    [x + 1, y - 1, z, w - 1],
    [x - 1, y, z, w - 1],
    [x + 1, y, z, w - 1],
    [x - 1, y + 1, z, w - 1],
    [x, y + 1, z, w - 1],
    [x + 1, y + 1, z, w - 1],

    [x, y, z - 1, w + 1],
    [x - 1, y - 1, z - 1, w + 1],
    [x, y - 1, z - 1, w + 1],
    [x + 1, y - 1, z - 1, w + 1],
    [x - 1, y, z - 1, w + 1],
    [x + 1, y, z - 1, w + 1],
    [x - 1, y + 1, z - 1, w + 1],
    [x, y + 1, z - 1, w + 1],
    [x + 1, y + 1, z - 1, w + 1],
    # top
    [x, y, z + 1, w + 1],
    [x - 1, y - 1, z + 1, w + 1],
    [x, y - 1, z + 1, w + 1],
    [x + 1, y - 1, z + 1, w + 1],
    [x - 1, y, z + 1, w + 1],
    [x + 1, y, z + 1, w + 1],
    [x - 1, y + 1, z + 1, w + 1],
    [x, y + 1, z + 1, w + 1],
    [x + 1, y + 1, z + 1, w + 1],
    # middle
    [x - 1, y - 1, z, w + 1],
    [x, y - 1, z, w + 1],
    [x + 1, y - 1, z, w + 1],
    [x - 1, y, z, w + 1],
    [x + 1, y, z, w + 1],
    [x - 1, y + 1, z, w + 1],
    [x, y + 1, z, w + 1],
    [x + 1, y + 1, z, w + 1]
  ]
end

def cycle(map)
  new_map = {}
  map.each do |cord, _state|
    neighbours_active = surrounding_cords(cord).map { |cord| map[cord] == '#' }.count(true)

    if map[cord] == '#' && (2..3).include?(neighbours_active) ||
       map[cord] == '.' && neighbours_active == 3
      new_map[cord] = '#'; next
    else
      new_map[cord] = '.'
    end
  end
  new_map
end

6.times do
  map = draw_bounds(map)
  map = cycle(map)
end

puts map.values.count('#')
