class WinningCondition
  def condition_checker(board, symbol)
    exitter(symbol) if outside_horizontal(board) || outside_vertical(board) || inside(board) || diagonal(board)
  end

  def outside_horizontal(board)
    board[0] == board[1] && board[0] == board[2] && board[0] != '_' ||
      board[6] == board[7] && board[6] == board[8] && board[7] != '_'
  end

  def outside_vertical(board)
    board[0] == board[3] && board[0] == board[6] && board[0] != '_' ||
      board[2] == board[5] && board[2] == board[8] && board[2] != '_'
  end

  def inside(board)
    board[1] == board[4] && board[1] == board[7] && board[1] != '_' ||
      board[3] == board[4] && board[3] == board[5] && board[3] != '_'
  end

  def diagonal(board)
    board[2] == board[4] && board[2] == board[6] && board[2] != '_' ||
      board[0] == board[4] && board[0] == board[8] && board[0] != '_'
  end
end
