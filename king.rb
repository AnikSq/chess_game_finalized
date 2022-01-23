# frozen_string_literal: true

class King
  attr_accessor :current_place, :dont_touch, :icon

  def initialize(row = 7, column = 3, color = 'black')
    @current_place = [row, column]
    @dont_touch = true
    @icon = if color == 'black'
              '♚'
            else
              '♔'
            end
  end

  # checking if the move is valid
  def valid_move(input)
    @all_possible_moves = [[@current_place[0] + 1, @current_place[1]],
                           [@current_place[0], (@current_place[1] + 1)],
                           [@current_place[0], (@current_place[1] - 1)],
                           [@current_place[0] - 1, @current_place[1]]]

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

kinggame = King.new(5, 2)
