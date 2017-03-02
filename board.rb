require_relative 'tile'

class Board
  attr_accessor :grid

  def initialize(dimensions)
    @grid = Array.new(dimensions) { Array.new(dimensions) }
    plant_mines
    plant_tiles
  end

  def length
    grid.length
  end

  def plant_mines(n = 80)
    n.times do
      pos = empty_squares.shuffle.first
      self[pos] = Tile.new(nil, true)
    end
  end

  def plant_tiles
    empty_squares.each do |pos|
      self[pos] = Tile.new(bomb_count(pos))
    end
  end

  def left(pos)
    y, x = pos
    # y is the row, and shifting through rows shifts through y-axis
    left = []

    left << [y - 1, x + 1] if valid_pos([y - 1, x + 1])
    left << [y - 1 , x] if valid_pos([y - 1 , x])
    left << [y - 1, x - 1] if valid_pos([y - 1, x - 1])

    left
  end

  def right(pos)
    y, x = pos
    right = []

    right << [y + 1, x + 1] if valid_pos([y + 1, x + 1])
    right << [y + 1 , x] if valid_pos([y + 1, x])
    right << [y + 1, x - 1] if valid_pos([y + 1, x - 1])

    right
  end

  def top_bottom(pos)
    y, x = pos
    top_bottom = []
    top_bottom << [y, x + 1] if valid_pos([y, x + 1])
    top_bottom << [y, x - 1]if valid_pos([y, x - 1])
    top_bottom
  end

  def valid_pos(pos)
    all_positions.include?(pos)
  end

  def adjacent_squares(pos)
    left(pos) + right(pos) + top_bottom(pos)
  end

  def bomb_count(pos)
    bomb_count = 0
    adjacent_squares(pos).each do |pos|
      if self[pos].is_a?(Tile)
        bomb_count += 1 if self[pos].bomb?
      end
    end

    bomb_count
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def empty_square?(pos)
    self[pos].nil?
  end

  def all_positions
    all_pos = []
    grid.each_index do |idx1|
      grid.each_index do |idx2|
        pos = [idx1, idx2]
        all_pos << pos
      end
    end

    all_pos
  end

  def empty_squares
    empty_squares = []
    grid.each_index do |idx1|
      grid.each_index do |idx2|
        pos = [idx1, idx2]
        empty_squares << pos if self[pos].nil?
      end
    end

    empty_squares
  end

  def render
    puts "  #{(0..(grid.length-1)).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      show_row = row.map { |tile| tile.revealed? ? tile.count.to_s : " " }
      puts "#{i} #{show_row.join(" ")}"
    end
  end

  def fringe(pos)
    tile = self[pos]
    return if tile.revealed?
    if tile.count > 0
      tile.reveal unless tile.bomb?
    else
      tile.reveal
      adjacent_squares(pos).each { |coord| fringe(coord) } #&& self[pos].bomb? == false
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new(3)
  board.plant_mines
  board.plant_tiles
  board.render
  # p board.clicked_squares
end
