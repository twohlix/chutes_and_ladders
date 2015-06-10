require_relative 'game.rb'

puts "Simulating 1000000 games of chutes and ladders"

board = Board.new

frequency_of_turns = Array.new 151, 0

(1..1000000).each do |game_number|
  game = Game.new board: board
  game.simulate

  frequency_of_turns[game.turns] += 1 if game.won?

  puts "simulated #{game_number} games" if game_number % 10000 == 0
end

puts frequency_of_turns
