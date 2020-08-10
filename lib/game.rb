class Game
  attr_reader :choices, :board
  def initialize
    @choices = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @board = %w[_ _ _ _ _ _ _ _ _]
  end

  def condition_checker(board, symbol)
    linear(board, symbol)
    exitter(symbol) if diagonal(board, symbol)
  end

  def linear(board, symbol)
    3.times do |ind|
      exitter(symbol) if board.each_slice(3).to_a[ind].all?(symbol) == true
    end
    3.times do |ind|
      exitter(symbol) if board.each_slice(3).to_a.transpose[ind].all?(symbol) == true
    end
  end

  def diagonal(board, symbol)
    board[2] == symbol && board[4] == symbol && board[6] == symbol ||
      board[0] == symbol && board[4] == symbol && board[8] == symbol
  end
end
