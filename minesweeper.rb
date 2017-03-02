class Minesweeper
  def initialize(board)
    @board = board
  end

  def get_move
    pos = nil
    until valid_move?(pos) && parse_move(pos).length == 2
      pos = gets.chomp
    end
    pos
  end

  def parse_move(pos)
    pos.split(",").map(&:to_i)
  end

  def valid_move?(pos)
    parse(pos).is_a?(Array) && parse(pos).all? { |el| el.between?(0, board.length-1) }
  end

  def over?
    board[get_move].bomb?
  end

end
