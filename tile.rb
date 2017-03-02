class Tile
  attr_accessor :revealed

  def initialize(count=nil, bomb = false)
    @bomb = bomb
    @count = count
    @revealed = false
  end

  def count
    @count = nil if bomb
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
