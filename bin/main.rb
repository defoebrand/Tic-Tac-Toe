#!/usr/bin/env ruby

require_relative '../lib/game'
require_relative '../lib/winning_condition'
require_relative '../lib/player_x'
require_relative '../lib/player_y'

def player1(choices, board)
  puts 'Player X - choose square 1-9'
  x_input = gets.chomp
  if x_input.match?(/\b[1-9]\b/)
    if choices.include?(x_input.to_i)
      choices.delete(x_input.to_i)
      board[x_input.to_i - 1] = 'x'
    else
      puts 'Incorrect input'
      player1(choices, board)
    end
  else
    puts 'Incorrect input'
    player1(choices, board)
  end
end

def player2(choices, board, opponent)
  puts 'Player O - choose square 1-9'
  o_input = if opponent == 'cpu'
              ((rand * 10) - 1).to_i.to_s
            else
              gets.chomp
            end
  if o_input.match?(/\b[1-9]\b/)
    if choices.include?(o_input.to_i)
      choices.delete(o_input.to_i)
      board[o_input.to_i - 1] = 'o'
    else
      puts 'Incorrect input'
      player2(choices, board, opponent)
    end
  else
    puts 'Incorrect input'
    player2(choices, board, opponent)
  end
end

def exitter(symbol)
  p "#{symbol} wins!"
  replay
end

def replay
  p 'Would you like to play again? Y/N'
  response = gets.chomp
  if response.downcase == 'y'
    @opponent_choice = nil
    choose_opponent(@opponent_choice)
    player1 = PlayerX.new
    player2 = PlayerY.new
    game = Game.new
    game_checker = WinningCondition.new
    run_game(player1, player2, game, game_checker)
  else
    p 'Goodbye!'
    exit
  end
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

def game_start_board_display
  puts "
Tic-Tac-Toe Game Board
1 2 3
4 5 6
7 8 9"
end

def game_play_board_display(board)
  puts "
  #{board[0]} #{board[1]} #{board[2]}
  #{board[3]} #{board[4]} #{board[5]}
  #{board[6]} #{board[7]} #{board[8]}
  "
end

player1 = PlayerX.new
player2 = PlayerY.new
game = Game.new
game_checker = WinningCondition.new

def run_game(player1, player2, game, game_checker)
  game_start_board_display
  0.upto(game.choices.length / 2) do
    choose_opponent(@opponent_choice)
    player1(game.choices, game.board)
    game_play_board_display(game.board)
    game_checker.condition_checker(game.board, player1.symbol)
    if game.choices.length.zero?
      puts "Cat's Game"
      replay
    else
      player2(game.choices, game.board, @opponent_choice)
      game_play_board_display(game.board)
      game_checker.condition_checker(game.board, player2.symbol)
    end
  end
end
run_game(player1, player2, game, game_checker)
