class Game
  attr_accessor :choices, :board
  def initialize
    @choices = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @board = %w[_ _ _ _ _ _ _ _ _]
  end
end
