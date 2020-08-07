#!/usr/bin/env ruby

require_relative '../lib/game'
require_relative '../lib/player'

def incorrect_input(symbol, choices, opponent)
  puts 'Incorrect input'
  input(symbol, choices, opponent)
end

def input(symbol, choices, opponent)
  puts "Player #{symbol} - choose square 1-9"
  input = if opponent == 'cpu' && symbol == 'o'
            choices.sample.to_s
          else
            gets.chomp
          end
  input
end

def exitter(symbol)
  p "#{symbol} wins!"
  replay
end

def opponent_dialogue
  p 'Who would you like your opponent to be? Human or CPU?'
  answer = gets.chomp.downcase
  answer
end

def try_again
  p 'Try Again'
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

player1 = Player.new('x')
player2 = Player.new('o')
game = Game.new

def replay
  p 'Would you like to play again? Y/N'
  response = gets.chomp
  if response.downcase == 'y'
    player1 = Player.new('x')
    player2 = Player.new('o')
    game = Game.new
    run_game(player1, player2, game)
  else
    p 'Goodbye!'
    exit
  end
end

def run_game(player1, player2, game)
  game_start_board_display
  player1.choose_opponent(player1.opponent_choice)
  0.upto(game.choices.length / 2) do
    input = input(player1.symbol, game.choices, player1.opponent_choice)
    player1.move(game.choices, game.board, input, player1.opponent_choice)
    game_play_board_display(game.board)
    game.condition_checker(game.board, player1.symbol)
    if game.choices.length.zero?
      puts "Cat's Game"
      replay
    else
      input = input(player2.symbol, game.choices, player1.opponent_choice)
      player2.move(game.choices, game.board, input, player1.opponent_choice)
      game_play_board_display(game.board)
      game.condition_checker(game.board, player2.symbol)
    end
  end
end
run_game(player1, player2, game)
