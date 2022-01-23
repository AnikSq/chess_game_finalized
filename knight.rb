# frozen_string_literal: true

class Knight
  attr_accessor :current_place, :dont_touch, :icon

  def initialize(row = 7, column = 1, color = 'black')
    @current_place = [row, column]
    @dont_touch = true
    @icon = if color == 'black'
              '♞'
            else
              '♘'
            end
  end

  # checking if the move is valid
  def valid_move(input)
    @all_possible_moves = [[@current_place[0] + 2, @current_place[1] + 1],
                           [@current_place[0] + 2, @current_place[1] - 1], [@current_place[0] + 1, @current_place[1] + 2], [@current_place[0] + 1, @current_place[1] - 2], [@current_place[0] - 2, @current_place[1] - 1], [@current_place[0] - 2, @current_place[1] + 1], [@current_place[0] - 1, @current_place[1] - 2], [@current_place[0] - 1, @current_place[1] + 2]]
    true if input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0 && @all_possible_moves.include?(input)
  end

  # Moving if it is a valid move
  def move(input)
    return false if !valid_move(input)

    @current_place = input
  end

  def special_capture_king(input)
    return @all_possible_moves if valid_move(input)
  end
end

newKnight = Knight.new(6, 3)

p newKnight.special_capture_king([7, 1]) # Current is 7 , 1
