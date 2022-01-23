# frozen_string_literal: true

class Rook
  attr_accessor :current_place, :icon

  def initialize(row = 7, column = 0, color = 'black')
    @current_place = [row, column]
    if color == 'black'
      @icon = '♜'
    else
      icon = '♖'
    end
  end

  # checking if the move is valid
  def valid_move(input)
    if input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0 && ((input[0] == @current_place[0] && input[1] != @current_place[1]) || (input[0] != @current_place[0] && input[1] == @current_place[1]))
      true
    end
  end

  # Moving if it is a valid move
  def move(input)
    return false if !valid_move(input)

    @current_place = input
  end

  def steps_to_reach(input)
    return false if !valid_move(input)

    first_current_index = @current_place[0]
    second_current_index = @current_place[1]
    first_switching_index = input[0]
    second_switching_index = input[1]

    if first_switching_index == first_current_index && second_switching_index < second_current_index
      array = []
      until second_current_index == second_switching_index
        second_current_index -= 1
        array.push([first_current_index, second_current_index])
      end

      array
    elsif first_switching_index == first_current_index && second_switching_index > second_current_index
      array = []
      until second_current_index == second_switching_index
        second_current_index += 1
        array.push([first_current_index, second_current_index])
      end

      array
    elsif first_switching_index > first_current_index && second_switching_index == second_current_index
      array = []
      until first_current_index == first_switching_index
        first_current_index += 1
        array.push([first_current_index, second_current_index])
      end

      array
    elsif first_switching_index < first_current_index && second_switching_index == second_current_index
      array = []
      until first_current_index == first_switching_index
        first_current_index -= 1
        array.push([first_current_index, second_current_index])
      end

      array
    end
  end
end

game = Rook.new(7, 7)
p game.steps_to_reach([7, 4])
