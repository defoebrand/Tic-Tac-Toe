#!/usr/bin/env ruby

class Game
  attr_accessor :array, :board
  def initialize
    @array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @board = %w[_ _ _ _ _ _ _ _ _]
  end
end

class PlayerX
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
  def player2(array, board)
    puts 'Player O - choose square 1-9'
    o_input = gets.chomp
    if o_input.match?(/\b[1-9]\b/)
      puts "Your input was #{o_input}"
      if array.include?(o_input.to_i)
        array.delete(o_input.to_i)
        board[o_input.to_i - 1] = 'o'
      else
        puts 'Incorrect input'
        player2(array, board)
      end
    else
      puts 'Incorrect input'
      player2(array, board)
    end
  end
end

class WinningCondition
  def condition_checker(board)
    exitter if winner1(board) || winner2(board) || winner3(board) || winner4(board)
  end

  def winner1(board)
    if board[0] == board[1] && board[0] == board[2] && board[0] != '_' ||
       board[3] == board[4] && board[3] == board[5] && board[3] != '_'
      true
    end
  end

  def winner2(board)
    if board[0] == board[3] && board[0] == board[6] && board[0] != '_' ||
       board[1] == board[4] && board[1] == board[7] && board[1] != '_'
      true
    end
  end

  def winner3(board)
    if board[0] == board[4] && board[0] == board[8] && board[0] != '_' ||
       board[2] == board[4] && board[2] == board[6] && board[2] != '_'
      true
    end
  end

  def winner4(board)
    if board[6] == board[7] && board[6] == board[8] && board[7] != '_' ||
       board[2] == board[5] && board[2] == board[8] && board[2] != '_'
      true
    end
  end

  def exitter
    p 'You win!'
    exit
  end
end

player1 = PlayerX.new
player2 = PlayerY.new
game = Game.new
game_checker = WinningCondition.new

0.upto(game.array.length / 2) do
  player1.player1(game.array, game.board)
  puts "
  #{game.board[0]} #{game.board[1]} #{game.board[2]}
  #{game.board[3]} #{game.board[4]} #{game.board[5]}
  #{game.board[6]} #{game.board[7]} #{game.board[8]}"
  game_checker.condition_checker(game.board)
  if game.array.length.zero?
    puts "Cat's Game"
  else
    player2.player2(game.array, game.board)
    puts "
    #{game.board[0]} #{game.board[1]} #{game.board[2]}
    #{game.board[3]} #{game.board[4]} #{game.board[5]}
    #{game.board[6]} #{game.board[7]} #{game.board[8]}"
    game_checker.condition_checker(game.board)
  end
end
