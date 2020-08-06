class Player
  attr_reader :symbol, :opponent_choice
  def initialize(symbol, opponent = nil)
    @symbol = symbol
    @opponent_choice = opponent
  end

  def move(choices, board, input, opponent)
    if input.match?(/\b[1-9]\b/)
      if choices.include?(input.to_i)
        choices.delete(input.to_i)
        board[input.to_i - 1] = @symbol
      else
        input = incorrect_input(@symbol, choices, opponent)
        move(choices, board, input, opponent)
      end
    else
      input = incorrect_input(@symbol, choices, opponent)
      move(choices, board, input, opponent)
    end
  end

  def choose_opponent(opponent)
    if opponent.nil?
      answer = opponent_dialogue
      if answer == 'cpu'
        @opponent_choice = 'cpu'
      elsif answer == 'human'
        @opponent_choice = 'human'
      else
        try_again
        choose_opponent(@opponent_choice)
      end
    end
    @opponent_choice
  end
end
