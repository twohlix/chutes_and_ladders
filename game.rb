require_relative 'board.rb'

class Game
  def initialize(options = {})
    player_count = options[:player_count] || 2
    @spinner_minimum = options[:spinner_min] || 1
    @spinner_maximum = options[:spinner_max] || 6
    @spinner_length = @spinner_maximum - @spinner_minimum
    @board = options[:board] || Board.new
    @turns = 0
    @max_turns = options[:max_turns] || 150
    @players = Array.new player_count, 0
    @won = false
  end

  attr_reader :turns

  def take_turn
    @turns += 1

    @players.each_index do |index|
      @players[index] = @board.move_from @players[index], roll

      if @players[index].nil? || @players[index] >= @board.max
        @won = true
        return false
      end
    end

    return false if @turns >= @max_turns
    true
  end

  def roll
    rand(@spinner_length) + @spinner_minimum
  end

  def won?
    @won
  end

  def simulate
    while take_turn
    end
  end

  def minimum_turns_required
    current_turn = 0
    previous_turns_results = [0]

    testing = true
    while(testing) do
      current_turn += 1
      puts "Testing Turn #{current_turn}"

      this_turns_results = []
      (@spinner_minimum..@spinner_maximum).each do |roll|
        previous_turns_results.each do |starting_space|
          this_move = @board.move_from starting_space, roll
          return current_turn if this_move.nil? || this_move >= @board.max
          this_turns_results << this_move
        end
      end

      previous_turns_results = this_turns_results
    end
  end
end
