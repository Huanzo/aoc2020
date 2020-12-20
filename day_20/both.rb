# frozen_string_literal: true

require 'pry'

# @type [Hash]
input = File.read('./input').split("\n\n").map do |tile|
  tile = tile.split("\n")
  id = tile.shift.scan(/\d+/).first.to_i
  Hash[id, tile]
end.inject :merge

# @type [Array]
$corners = []

def build_combinations(tile)
  top = tile.first
  rev_top = top.reverse
  btm = tile.last
  rev_btm = btm.reverse
  left = tile.map { |a| a[0] }.join
  rev_left = left.reverse
  right = tile.map { |a| a[-1] }.join
  rev_right = right.reverse
  [left, rev_left, right, rev_right, top, rev_top, btm, rev_btm]
end

def get_sides(tile)
  top = tile.first
  btm = tile.last
  left = tile.map { |a| a[0] }
  right = tile.map { |a| a[-1] }
  [top, btm, left, right]
end

def check_tile(tile, input)
  tile_id = tile.first
  combs = build_combinations(tile.last)

  t = input.map do |id, val|
    next if tile_id == id

    (combs & build_combinations(val)).count
  end
end

input.each do |tile|
  $corners << tile.first if check_tile(tile, input).count(2) == 2
end

class Tile
  attr_accessor :id, :grid
  def initialize(id, grid)
    @id = id
    @grid = grid
  end

  def top
    @grid.first.join
  end

  def btm
    @grid.last.join
  end

  def left
    @grid.map(&:first).join
  end

  def right
    @grid.map(&:last).join
  end

  def grid_without_borders
    out = []
    @grid.each_with_index do |line, i|
      next if i == 0
      next if i == 9

      out << line[1..-2]
    end
    out
  end

  def edges
    [top, right, btm, left]
  end

  def edge_orientations
    out = [*edges]
    out.push(*edges.map(&:reverse))
    out
  end

  def flip_vertical
    self.class.new @id, @grid.map(&:reverse)
  end

  def flip_horizontal
    self.class.new @id, @grid.reverse
  end

  def rotate
    self.class.new @id, @grid.transpose.map(&:reverse)
  end

  def all_rotations
    out = [self]
    3.times do
      out << out.last.rotate
    end
    out
  end

  def all_orientations
    out = [self, flip_horizontal, flip_vertical, flip_horizontal.flip_vertical]
    out.dup.each do |tile|
      out.push(*tile.all_rotations)
    end
    out.uniq
  end

  def to_s
    @grid.map(&:join).join "\n"
  end

  def find_matching_right_from(tiles)
    tiles.map(&:all_orientations).flatten.uniq.each do |ori|
      return ori if right == ori.left
    end
  end

  def find_matching_bottom_from(tiles)
    tiles.map(&:all_orientations).flatten.uniq.each do |ori|
      return ori if btm == ori.top
    end
  end

  def find_monsters
    count = 0
    image = to_s.lines.map(&:chomp)
    image[0..-3].each_with_index do |row, y|
      row[0..-20].chars.each_index do |x|
        count += 1 if monster_at?(x, y, image)
      end
    end
    count
  end

  def monster_at?(x, y, image)
    MONSTER.each_with_index do |regex, i|
      return false unless image[y + i][x, 20][regex]
    end
    true
  end
end

def rotate_top_left(tl)
  tl.all_orientations.each do |ori|
    left_side = ori.left
    top_side = ori.top

    unless $all_orientations.include?(left_side) || $all_orientations.include?(top_side)
      return ori
    end
  end
  nil
end

# @type [Array]
$tiles = input.map do |id, grid|
  Tile.new id, grid.map(&:chars)
end

top_left = $tiles.find { |tile| tile.id == $corners.first }
$tiles.delete(top_left)
$all_orientations = $tiles.map(&:edge_orientations).flatten.uniq

$map = [[]]
$map[0] << rotate_top_left(top_left)

11.times do
  $map[0] << $map[0].last.find_matching_right_from($tiles)
  $tiles.delete($tiles.find { |t| t.id == $map[0].last.id })
  $map << [$map.last.first.find_matching_bottom_from($tiles)]
  $tiles.delete($tiles.find { |t| t.id == $map.last.last.id })
end

(1..11).each do |y|
  11.times do
    $map[y] << $map[y].last.find_matching_right_from($tiles)
    $tiles.delete($tiles.find { |t| t.id == $map[y].last.id })
  end
end

corners = [$map[0][0].id, $map[0][11].id, $map[11][0].id, $map[11][11].id]
puts "Corners: #{$corners.inspect}"
puts "Product of corner ids: #{corners.inject(:*)}"
MONSTER = [
  /..................#./,
  /#....##....##....###/,
  /.#..#..#..#..#..#.../
].freeze
image = ''

$map.each do |row|
  out = Array.new(8) { '' }
  row.each do |tile|
    tile.grid_without_borders.each_with_index do |line, i|
      out[i] += line.join
    end
  end
  image += out.join "\n"
  image += "\n"
end

image = image.lines.map(&:chomp)
image = Tile.new 1, image.map(&:chars)

monsters = 0
image.all_orientations.each do |ori|
  monsters = ori.find_monsters

  break if monsters > 0
end

puts "Monsters: #{monsters}"
puts "Num of '#' not belonging to monster: #{image.to_s.count('#') - 15 * monsters}"
