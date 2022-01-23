# frozen_string_literal: true

class Board
  attr_accessor :board

  def initialize
    @size = 64
    @each_row = 8
    @each_column = 8
    @board = Array.new(8) { Array.new(8, ' ') }
  end
end

all_other_blacks = [@black_king, @black_knight1, @black_knight2, @black_pawn, @black_pawn, @black_pawn, @black_pawn,
                    @black_pawn, @black_pawn, @black_pawn, @black_pawn]
