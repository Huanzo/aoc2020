input = File.readlines('./input').map(&:chomp)

class Tile
  attr_accessor :x, :y, :z, :black, :white

  NEIGHBOURS = {
    'nw' => [0, +1, -1],
    'ne' => [1, 0, -1],
    'sw' => [-1, 0, +1],
    'se' => [0, -1, +1],
    'e' => [+1, -1, 0],
    'w' => [-1, 1, 0]
  }

  def initialize(x,y,z)
    @x, @y, @z = x, y, z
    @black = false
    @white = true
  end

  def walk_and_flip(dir)
    if dir.empty?
      @black, @white = @white, @black
      return
    end
    move = if %w[se sw ne nw].include? dir[0,2]
            move = dir[0,2]
            dir.gsub!(/^../, '')
            move
          else
            move = dir[0,1]
            dir.gsub!(/^./, '')
            move
          end

    offset = NEIGHBOURS[move]
    next_coord = [@x, @y, @z].map.with_index {|c,i| c+offset[i]}
    tile = if $tiles[next_coord]
             $tiles[next_coord]
           else
             tile = Tile.new(*next_coord)
             $tiles[next_coord] = tile
             tile
           end
    tile.walk_and_flip(dir)
  end

  def next_day
    neigh = neighbours
    new_tile = self.dup
    if @black && [0,3,4,5,6].include?(neigh.count(&:black))
      new_tile.black = false
      new_tile.white = true
    elsif @white && neigh.count(&:black) == 2
      new_tile.black = true
      new_tile.white = false
    end
    new_tile
  end

  def neighbours
    NEIGHBOURS.values.map do |offset|
      next_coord = [@x, @y, @z].map.with_index {|c,i| c+offset[i]}
      tile = if $tiles[next_coord]
               $tiles[next_coord]
             else
               Tile.new(*next_coord)
             end

    end
  end
end

def draw_bounds
  $tiles.values.each do |t|
    t.neighbours.each do |n|
      $tiles[[n.x, n.y, n.z]] = n
    end
  end
end

$tiles = {[0,0,0] => Tile.new(0,0,0)}

input.each do |dir|
  $tiles[[0,0,0]].walk_and_flip(dir)
end
puts $tiles.values.count(&:black)

$new_tiles = {}

100.times do |i|
  draw_bounds
  $tiles.each do |coord, tile|
    $new_tiles[coord] = tile.next_day
  end
  $tiles = $new_tiles
  $new_tiles = {}
end
puts $tiles.values.count(&:black)
