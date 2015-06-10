require_relative 'board.rb'

class Game
  def initialize(options={})
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

  def turns
    @turns
  end

  def won?
    @won
  end

  def simulate
    while take_turn
    end
  end
end
