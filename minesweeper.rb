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
    board.fringe(pos)
  end

  def play
    system('clear')
    display
    pos = get_move
    make_move(pos)
  end

  # def run
  #   play until over?
  # end


end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(Board.new(9))
  game.display
  move = game.get_move
  game.make_move(move)
  game.display
end
