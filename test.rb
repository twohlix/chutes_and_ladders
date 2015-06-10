require_relative 'game.rb'
require 'optparse'

def puts_histogram(the_array)
  max_value = the_array.max

  histogram_max_characters = 50

  the_array.each_index do |index|
    tail = '#' * (histogram_max_characters * (the_array[index].to_f / max_value.to_f)).to_i
    puts "#{index}:\t#{tail} #{the_array[index]}"
  end
end

def simulate_games(games_to_simulate)
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

    Thread.current[:simulated_games] = game_number
  end

  return { frequency_of_turns: frequency_of_turns, number_of_wins: number_of_wins, games_simulated: games_simulated }
end

options = { games_to_simulate: 1000000, number_of_threads: 1 }
opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} [options]"

  opts.on('-g GAMES', '--games GAMES', Integer, "Number of games to simulate [#{options[:games_to_simulate]}]") do |g|
    options[:games_to_simulate] = g
  end

  opts.on('-t THREADS', '--threads THREADS', Integer, "Number of Threads to use [#{options[:number_of_threads]}]") do |t|
    options[:number_of_threads] = t
  end

  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end

opt_parser.parse!(ARGV)

games_to_simulate = options[:games_to_simulate]
number_of_threads = options[:number_of_threads]
puts "Simulating #{games_to_simulate} games of chutes and ladders on #{number_of_threads} threads"

threads = []
number_of_threads.times do |i|
  threads[i] = Thread.new { Thread.current[:results] = simulate_games(games_to_simulate/number_of_threads) }
end

thread_results = []
frequency_of_turns = Array.new 151, 0
threads.each do |t|
  t.join
  thread_results << t[:results]
  thread_results[-1][:frequency_of_turns].each_index do |index|
    frequency_of_turns[index] += thread_results[-1][:frequency_of_turns][index]
  end
end

puts_histogram frequency_of_turns
#puts "#{number_of_wins} games won of #{games_simulated} simulated games"
