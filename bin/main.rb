#!/usr/bin/env ruby

class Game
  attr_reader :array

  @@array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def array
    @@array
  end

  def player1
    puts 'Player X - choose square 1-9'
    x_input = gets.chomp
    if x_input.match?(/\b[1-9]\b/)
      puts "Your input was #{x_input}"

      if @@array.include?(x_input.to_i)
        @@array.delete(x_input.to_i)
      else

        puts 'Incorrect input'
        player1
      end
    else
      puts 'Incorrect input'
      player1
    end
    # p @@array
  end

  def player2
    puts 'Player O - choose square 1-9'
    o_input = gets.chomp
    if o_input.match?(/\b[1-9]\b/)

      puts "Your input was #{o_input}"

      if @@array.include?(o_input.to_i)
        @@array.delete(o_input.to_i)
      else

        puts 'Incorrect input'
        player2
      end
    else
      puts 'Incorrect input'
      player2
    end
    # p @@array
  end
end

new_game = Game.new

0.upto(new_game.array.length / 2) do
  new_game.player1
  if new_game.array.length == 0
    puts 'Game Over!'
  else
    new_game.player2
  end
end
