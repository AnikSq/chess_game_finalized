# frozen_string_literal: true

require 'byebug'
class Bishop
  attr_accessor :current_place, :icon

  def initialize(row = 7, column = 2, color = 'black')
    @current_place = [row, column]
    if color == 'black'
      @icon = '♝'
    else
      @icon = '♗'
    end

  end

  # checking if the move is valid
  def valid_move(input)
    if input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0 && input[0] != @current_place[0] && input[1] != @current_place[1] &&
       (([input[0], @current_place[0]].max - [input[0], @current_place[0]].min) == ([input[1], @current_place[1]].max - [input[1], @current_place[1]].min)) # the remainder is to check if two values are incremened samely like [1,1] to [2,2]
      true
    end
  end

  # Moving if it is a valid move
  def move(input)
    return false if !valid_move(input)

    @current_place = input
  end

  def steps_to_reach(input)
    return false unless valid_move(input)

    first_current_index = @current_place[0]
    second_current_index = @current_place[1]
    first_switching_index = input[0]
    second_switching_index = input[1]

    if first_switching_index < first_current_index && second_switching_index < second_current_index
      array = []
      until first_current_index == first_switching_index && second_current_index == second_switching_index
        first_current_index -= 1
        second_current_index -= 1
        array.push([first_current_index, second_current_index])
      end
      array
    elsif first_switching_index > first_current_index && second_switching_index > second_current_index
      array = []
      until first_current_index == first_switching_index && second_current_index == second_switching_index
        first_current_index += 1
        second_current_index += 1
        array.push([first_current_index, second_current_index])
      end
      array
    elsif first_switching_index > first_current_index && second_switching_index < second_current_index
      array = []
      until first_current_index == first_switching_index && second_current_index == second_switching_index
        first_current_index += 1
        second_current_index -= 1
        array.push([first_current_index, second_current_index])
      end
      array
    elsif first_switching_index < first_current_index && second_switching_index > second_current_index
      array = []
      until first_current_index == first_switching_index && second_current_index == second_switching_index
        first_current_index -= 1
        second_current_index += 1
        array.push([first_current_index, second_current_index])
      end
      array
    end
  end
end

game = Bishop.new(5, 4)
p game.steps_to_reach([1, 0])
