require_relative 'board'
require_relative 'tile'

class Minesweeper
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def get_move
    pos = nil
    until valid_move?(pos) && parse_move(pos).length == 2
      puts "Pick a square in 'x,y' format"
      print "> "
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

  # def over?
  #   board[pos].bomb?
  # end

  def display
    board.render
  end
  #
  # def make_move(pos)
  #   board[pos].reveal
  # end
  #
  # def play
  #   system('clear')
  #   display
  #   get_move
  # end
  #
  # def run
  #   play until over?
  # end


end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(Board.new(9))
  game.display
end
