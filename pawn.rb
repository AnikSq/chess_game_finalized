# frozen_string_literal: true
class Pawn
  attr_accessor :current_place, :bool, :icon, :color

  def initialize(row = 1, column = 1, color = 'black')
    @current_place = [row, column]
    @bool = true
    @color = color
    @icon = if color == 'black'
              '♟'
            else
              '♙'
            end
  end

  # checking if the move is valid
  def valid_move(input)
    if input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0

      case @color
      when 'white'
        if input[0] == @current_place[0] + 1 && input[1] == current_place[1]
          return true
        elsif @bool && (input[0] == @current_place[0] + 2 && input[1] == current_place[1])
          @bool = false
          return true
        end
      when 'black'
        if input[0] == @current_place[0] - 1 && input[1] == current_place[1]
          return true
        elsif @bool && (input[0] == @current_place[0] - 2 && input[1] == current_place[1])
          @bool = false
          return true
        end
      end
    end
  end

  def capture_move(input)
    
    @all_possible_moves_black = [[@current_place[0] - 1, @current_place[1] + 1],
                                 [@current_place[0] - 1, @current_place[1] - 1]]
    @all_possible_moves_white = [[@current_place[0] + 1, @current_place[1] + 1],
                                 [@current_place[0] + 1, @current_place[1] - 1]]
    if input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0
      if @color == 'black' && @all_possible_moves_black.include?(input)
        @current_place = input
      elsif @color == 'white' && @all_possible_moves_white.include?(input)
        @current_place = input
      end
    end
  end

  # Moving if it is a valid move
  def move(input)
    
    return false if !valid_move(input) 

    @current_place = input
  end

  def special_capture_king(input)
    capture_move(input)
    return @all_possible_moves_black if @color == 'black'
    return @all_possible_moves_white if @color == 'white'
  end
end


pawn = Pawn.new(5,4)
p pawn.valid_move([4,4])
