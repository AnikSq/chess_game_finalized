class Queen
    attr_accessor :current_place, :icon
    def initialize(row = 7, column = 4,color = 'black')
        @current_place = [row,column]
        if color == 'black'
            @icon = '♛'
        else
            icon = '♕'
        end
    end

    #Queen is a mix of the 2 most powerful pieces in chess bishop && Rook

    def valid_move(input) #checking if the move is valid 
        if (input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0 && ((input[0] == @current_place[0] && input[1] != @current_place[1]) || (input[0] != @current_place[0] && input[1] == @current_place[1])))||
            (input[0] < 8 && input[1] < 8 && input[0] >= 0 && input[1] >= 0 && input[0] != @current_place[0] && input[1] != @current_place[1]&&
            (([input[0],@current_place[0]].max - [input[0],@current_place[0]].min) == ([input[1],@current_place[1]].max - [input[1],@current_place[1]].min)))

            return true
        end
    end 

    def move(input) #Moving if it is a valid move 
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
                second_current_index = second_current_index - 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index == first_current_index && second_switching_index > second_current_index
            array = []
            until second_current_index == second_switching_index
                second_current_index = second_current_index + 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index > first_current_index && second_switching_index == second_current_index
            array = []
            until first_current_index == first_switching_index
                first_current_index = first_current_index + 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index < first_current_index && second_switching_index == second_current_index
            array = []
            until first_current_index == first_switching_index
                first_current_index = first_current_index - 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index < first_current_index && second_switching_index < second_current_index
            array = []
            until first_current_index == first_switching_index && second_current_index == second_switching_index
                first_current_index = first_current_index - 1
                second_current_index = second_current_index - 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index > first_current_index && second_switching_index > second_current_index
            array = []
            until first_current_index == first_switching_index && second_current_index == second_switching_index
                first_current_index = first_current_index + 1
                second_current_index = second_current_index + 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index > first_current_index && second_switching_index < second_current_index
            array = []
            until first_current_index == first_switching_index && second_current_index == second_switching_index
                first_current_index = first_current_index + 1
                second_current_index = second_current_index - 1
                array.push([first_current_index,second_current_index])
            end
            return array
        elsif first_switching_index < first_current_index && second_switching_index > second_current_index
            array = []
            until first_current_index == first_switching_index && second_current_index == second_switching_index
                first_current_index = first_current_index - 1
                second_current_index = second_current_index + 1
                array.push([first_current_index,second_current_index])
            end
            return array
        end
    end
end

