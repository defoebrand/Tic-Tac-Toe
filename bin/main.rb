#!/usr/bin/env ruby

class Game
  attr_accessor :array, :board
  def initialize
    @array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @board = %w[_ _ _ _ _ _ _ _ _]
  end
end

class PlayerX
  attr_accessor :symbol
  def initialize
    @symbol = 'X'
  end

  def player1(array, board)
    puts 'Player X - choose square 1-9'
    x_input = gets.chomp
    if x_input.match?(/\b[1-9]\b/)
      puts "Your input was #{x_input}"
      if array.include?(x_input.to_i)
        array.delete(x_input.to_i)
        board[x_input.to_i - 1] = 'x'
      else
        puts 'Incorrect input'
        player1(array, board)
      end
    else
      puts 'Incorrect input'
      player1(array, board)
    end
  end
end

class PlayerY
  attr_accessor :symbol
  def initialize
    @symbol = 'O'
  end

  def player2(array, board, opponent)
    puts 'Player O - choose square 1-9'
    o_input = if opponent == 'cpu'
                ((rand * 10) - 1).to_i.to_s
              else
                gets.chomp
              end
    if o_input.match?(/\b[1-9]\b/)
      puts "Your input was #{o_input}"
      if array.include?(o_input.to_i)
        array.delete(o_input.to_i)
        board[o_input.to_i - 1] = 'o'
      else
        puts 'Incorrect input'
        player2(array, board, opponent)
      end
    else
      puts 'Incorrect input'
      player2(array, board, opponent)
    end
  end
end

class WinningCondition
  def condition_checker(board, symbol)
    exitter(symbol) if outside_horizontal(board) || outside_vertical(board) || inside(board) || diagonal(board)
  end

  def outside_horizontal(board)
    if board[0] == board[1] && board[0] == board[2] && board[0] != '_' ||
       board[6] == board[7] && board[6] == board[8] && board[7] != '_'
      true
    end
  end

  def outside_vertical(board)
    if board[0] == board[3] && board[0] == board[6] && board[0] != '_' ||
       board[2] == board[5] && board[2] == board[8] && board[2] != '_'
      true
    end
  end

  def inside(board)
    if board[1] == board[4] && board[1] == board[7] && board[1] != '_' ||
       board[3] == board[4] && board[3] == board[5] && board[3] != '_'
      true
    end
  end

  def diagonal(board)
    if board[2] == board[4] && board[2] == board[6] && board[2] != '_' ||
       board[0] == board[4] && board[0] == board[8] && board[0] != '_'
      true
    end
  end

  def exitter(symbol)
    p "#{symbol} wins!"
    exit
  end
end

class Opponent
  attr_accessor :opponent_choice
  def initialize
    @opponent_choice = nil
    @answer = nil
  end

  def choose_opponent(opponent)
    if opponent.nil?
      p 'Who would you like your opponent to be? Human or CPU?'
      answer = gets.chomp.downcase
      if answer == 'cpu'
        @opponent_choice = 'cpu'
      elsif answer == 'human'
        @opponent_choice = 'human'
      else
        p 'Try Again'
        choose_opponent(opponent)
      end
    end
    @opponent_choice
  end
end

player1 = PlayerX.new
player2 = PlayerY.new
game = Game.new
game_checker = WinningCondition.new
opponent = Opponent.new

0.upto(game.array.length / 2) do
  opponent.choose_opponent(opponent.opponent_choice)
  player1.player1(game.array, game.board)
  puts "
  #{game.board[0]} #{game.board[1]} #{game.board[2]}
  #{game.board[3]} #{game.board[4]} #{game.board[5]}
  #{game.board[6]} #{game.board[7]} #{game.board[8]}"
  game_checker.condition_checker(game.board, player1.symbol)
  if game.array.length.zero?
    puts "Cat's Game"
  else
    player2.player2(game.array, game.board, opponent.opponent_choice)
    puts "
    #{game.board[0]} #{game.board[1]} #{game.board[2]}
    #{game.board[3]} #{game.board[4]} #{game.board[5]}
    #{game.board[6]} #{game.board[7]} #{game.board[8]}"
    game_checker.condition_checker(game.board, player2.symbol)
  end
end
