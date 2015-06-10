require_relative 'game.rb'

def puts_histogram(the_array)
  max_value = the_array.max

  histogram_max_characters = 50

  the_array.each_index do |index|
    tail = '#' * (histogram_max_characters * (the_array[index].to_f / max_value.to_f)).to_i
    puts "#{index}:\t#{tail} #{the_array[index]}"
  end
end

games_to_simulate = 10000000
puts "Simulating #{games_to_simulate} games of chutes and ladders"

board = Board.new
frequency_of_turns = Array.new 151, 0
number_of_wins = games_simulated = 0

(1..games_to_simulate).each do |game_number|
  game = Game.new board: board
  game.simulate

  games_simulated += 1

  if game.won?
    frequency_of_turns[game.turns] += 1
    number_of_wins += 1
  end

  puts "simulated #{game_number} games" if game_number % 10000 == 0
end

puts_histogram frequency_of_turns
puts "#{number_of_wins} games won of #{games_simulated} simulated games"
