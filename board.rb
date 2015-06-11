class Board
  def initialize
    @board = Array.new(101) { |index| index }

    # ladders
    @board[1] = 38
    @board[4] = 14
    @board[9] = 31
    @board[21] = 42
    @board[28] = 84
    @board[36] = 44
    @board[51] = 67
    @board[71] = 91
    @board[80] = 100
    # chutes
    @board[16] = 6
    @board[49] = 11
    @board[62] = 19
    @board[87] = 24
    @board[48] = 26
    @board[56] = 53
    @board[64] = 60
    @board[93] = 73
    @board[95] = 75
    @board[98] = 78
  end

  def move_to(space_number)
    @board[space_number]
  end

  def move_from(space_number, distance)
    move_to space_number + distance
  end

  def max
    @board.size
  end
end
