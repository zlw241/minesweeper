require_relative 'board'
require_relative 'tile'

class Minesweeper
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def get_move
    pos = nil
    until valid_move?(pos) && pos.length == 2
      puts "Pick a square in 'x,y' format"
      print "> "
      pos = gets.chomp.split(",").map(&:to_i)
    end
    pos
  end

  def valid_move?(pos)
    pos.is_a?(Array) && pos.all? { |el| el.between?(0, board.length - 1) }
  end

  def display
    board.render
  end
  #
  # def over?
  #   board[pos].bomb?
  # end

  def make_move(pos)
    return -1 if board[pos].bomb?
    board.fringe(pos)
  end

  def play
    until board.empty_squares.length == 0
      system('clear')
      display
      pos = get_move
      return "You lost" if self.bomb?
      make_move(pos)
    end
    "You won!"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(Board.new(9))
  game.display
  move = game.get_move
  game.make_move(move)
  game.display
end
