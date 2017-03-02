class Tile
  attr_accessor :revealed, :count
  attr_reader :bomb

  def initialize(count=nil, bomb = false)
    @bomb = bomb
    @count = count
    @revealed = false
  end

  def revealed?
    revealed
  end

  def reveal
    self.revealed = true
  end

  def bomb?
    @bomb
  end
end
