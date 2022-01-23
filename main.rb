load './chess_board.rb'
load './king.rb'
load './pawn.rb'
load './queen.rb'
load './bishop.rb'
load './knight.rb'
load './rook.rb'
require 'json'
require 'byebug'
class ChessGame
    attr_accessor :player_one_name , :player_two_name , :chess_board
    def initialize(player_one_name , player_two_name)
        @player_one_name = player_one_name
        @player_two_name = player_two_name
        @chess_board = Board.new
        @reference_chess_board = Board.new
    end



    def black_initialization
        @black_king = King.new
        @black_queen = Queen.new
        @black_rook1 = Rook.new
        @black_rook2 = Rook.new(7, 7)
        @black_knight1 = Knight.new
        @black_knight2 = Knight.new(7, 6)
        @black_bishop1 = Bishop.new
        @black_bishop2 = Bishop.new(7 , 5)
        @black_pawn1 = Pawn.new(6,0)
        @black_pawn2 = Pawn.new(6,1)
        @black_pawn3 = Pawn.new(6,2)
        @black_pawn4 = Pawn.new(6,3)
        @black_pawn5 = Pawn.new(6,4)
        @black_pawn6 = Pawn.new(6,5)
        @black_pawn7 = Pawn.new(6,6)
        @black_pawn8 = Pawn.new(6,7)
    end

    def white_initialization
        @white_king = King.new(0, 3, 'white')
        @white_queen = Queen.new(0, 4, 'white')
        @white_rook1 = Rook.new(0, 0, 'white')
        @white_rook2 = Rook.new(0, 7, 'white')
        @white_knight1 = Knight.new(0, 1, 'white')
        @white_knight2 = Knight.new(0, 6, 'white')
        @white_bishop1 = Bishop.new(0, 2, 'white')
        @white_bishop2 = Bishop.new(0 , 5, 'white')
        @white_pawn1 = Pawn.new(1,0,'white')
        @white_pawn2 = Pawn.new(1,1,'white')
        @white_pawn3 = Pawn.new(1,2,'white')
        @white_pawn4 = Pawn.new(1,3,'white') 
        @white_pawn5 = Pawn.new(1,4,'white')
        @white_pawn6 = Pawn.new(1,5,'white')
        @white_pawn7 = Pawn.new(1,6,'white')
        @white_pawn8 = Pawn.new(1,7,'white')
    end

    def placing(item,icon)
        @chess_board.board[item.current_place[0]][item.current_place[1]] = icon
        @reference_chess_board.board[item.current_place[0]][item.current_place[1]] = item
    end


    def final_phase(color,player)
        i_feel_right = false
        until i_feel_right
            show_chess_board
            if player == 1
                p 'player 1 turn'
            else
                p 'player 2 turn'
            end
            white_array = [@white_king,@white_queen,@white_rook1,@white_rook2,@white_knight1,@white_knight2,@white_bishop1,@white_bishop2,@white_pawn1,@white_pawn2,@white_pawn3,@white_pawn4,@white_pawn5,@white_pawn6,@white_pawn7,@white_pawn8]
            black_array = [@black_king,@black_queen,@black_rook1,@black_rook2,@black_knight1,@black_knight2,@black_bishop1,@black_bishop2,@black_pawn1,@black_pawn2,@black_pawn3,@black_pawn4,@black_pawn5,@black_pawn6,@black_pawn7,@black_pawn8]
            #Working
            row = 10
            column = 10
            get_row = 10
            get_column = 10
            until row >= 0 && row < 8 && column >= 0 && column < 8 && get_row >= 0 && get_row < 8 && get_column >= 0 && get_column < 8
                p 'row'
                row = gets.chomp.to_i
                p 'column'
                column = gets.chomp.to_i
                show_chess_board
                p 'get to row , column'
                p 'row'
                get_row = gets.chomp.to_i
                p 'column'
                get_column = gets.chomp.to_i
            end
            the_requested_item = @reference_chess_board.board[row][column]
            ritem = " "
            
            if color == 'black'
                black_array.each do |ele|
                    if ele == the_requested_item
                        ritem = ele
                        i_feel_right = true
                    end
                end
            else
                white_array.each do |ele|
                    if ele == the_requested_item
                        ritem = ele
                        i_feel_right = true
                    end
                end
            end
            if ritem == " "
                puts 'you entered a wrong item'
            else
                
                if color == 'black'
                    if update_move(ritem,[get_row,get_column],color,ritem.icon)
                        @reference_chess_board.board[get_row][get_column] = @reference_chess_board.board[row][column]
                        @reference_chess_board.board[row][column] = " "
                    end
                else
                    if update_move(ritem,[get_row,get_column],color,ritem.icon)
                        @reference_chess_board.board[get_row][get_column] = @reference_chess_board.board[row][column]
                        @reference_chess_board.board[row][column] = " "
                    end
                end
        
                show_chess_board
            end
        end
        
    end
    def play_game
        black_initialization
        black_placing
        white_initialization
        white_placing
        until win?('black') || win?('white')
            final_phase('black',1)
            final_phase('white',2)
        end

    end


    def win?(color)
        white_icons = ['♔','♕','♖','♗','♘','♙']
        black_icons = ['♚','♛','♜','♝','♞','♟']
        if color == 'black'
            if @chess_board.board.flatten.include?('♔')
                return false
            end
            p "Yahooooooooooo player 1 have won!"
            return true
        end

        if color == 'white'
            if @chess_board.board.flatten.include?('♚')
                return false
            end
            p "Yahoooooooooo Player 2 have won!"
            return true
        end
    end

    def white_placing
        #King
        placing(@white_king , '♔')
        #Queen
        placing(@white_queen , '♕')
        #Rook1
        placing(@white_rook1 , '♖')
        #Rook2
        placing(@white_rook2 , '♖')
        #Knight1
        placing(@white_knight1 , '♘')
        #Knight2
        placing(@white_knight2 , '♘')
        #Bishop1
        placing(@white_bishop1 , '♗')
        #Bishop2
        placing(@white_bishop2 , '♗')
        #Pawn1
        placing(@white_pawn1 , '♙')
        #Pawn2
        placing(@white_pawn2 , '♙')
        #Pawn3
        placing(@white_pawn3 , '♙')
        #Pawn4
        placing(@white_pawn4 , '♙')
        #Pawn5
        placing(@white_pawn5 , '♙')
        #Pawn6
        placing(@white_pawn6 , '♙')
        #Pawn7
        placing(@white_pawn7 , '♙')
        #Pawn8
        placing(@white_pawn8 , '♙')
    end

    def black_placing
        #King
        placing(@black_king , '♚')
        #Queen
        placing(@black_queen , '♛')
        #Rook1
        placing(@black_rook1 , '♜')         
        #Rook2
        placing(@black_rook2 , '♜')
        #Knight1
        placing(@black_knight1 , '♞')
        #Knight2
        placing(@black_knight2 , '♞')
        #Bishop1
        placing(@black_bishop1 , '♝')
        #Bishop2
        placing(@black_bishop2 , '♝')
        #Pawn1
        placing(@black_pawn1 , '♟')
        #Pawn2
        placing(@black_pawn2 , '♟')
        #Pawn3
        placing(@black_pawn3 , '♟')
        #Pawn4
        placing(@black_pawn4 , '♟')
        #Pawn5
        placing(@black_pawn5 , '♟')
        #Pawn6
        placing(@black_pawn6 , '♟')
        #Pawn7
        placing(@black_pawn7 , '♟')
        #Pawn8
        placing(@black_pawn8 , '♟')
    end




    def update_move(update_item,index_update,player_color,icon)
        #Since Knights can jump over items they aren't necessery for the checks 
        if !(update_item == @white_knight1 || update_item == @white_knight2 || update_item == @black_knight1 || update_item == @black_knight2)
            return false if !step_valid(update_item,index_update)
        end
        
        #Making sure the user isn't requesting anything out of the board's scope
        if index_update[0] > 7 || index_update[1] > 7 || index_update[0] < 0 || index_update[1] < 0
            return false
        end
        
        # If the space is empty then just go to the empty place 
        if icon == '♚' || icon == '♔'
            if saving_king(player_color,index_update) == false
                return false
            end
        end


        if @chess_board.board[index_update[0]][index_update[1]] == " "
            
            @chess_board.board[update_item.current_place[0]][update_item.current_place[1]] = ' '
            if update_item.move(index_update)
                @chess_board.board[update_item.current_place[0]][update_item.current_place[1]] = icon
                return true;
            else
                @chess_board.board[update_item.current_place[0]][update_item.current_place[1]] = icon
                return false;
            end
        else
            return true if one_piece_out(update_item,index_update,player_color,icon)
        end
    end


    def saving_king(color,input)
        #other checks need opponent king , knight , pawn
        
        all_other_whites = [@white_king, @white_knight1,@white_knight2, @white_pawn1,@white_pawn2,@white_pawn3,@white_pawn4,@white_pawn5,@white_pawn6,@white_pawn7,@white_pawn8 ]
        all_other_blacks = [@black_king, @black_knight1,@black_knight2, @black_pawn1,@black_pawn2,@black_pawn3,@black_pawn4,@black_pawn5,@black_pawn6,@black_pawn7,@black_pawn8 ]
        

        if color == 'white'
            all_other_blacks.each do |ele|
                if ele.special_capture_king(input)
                    if ele.special_capture_king(input).include?(input)
                        p "Check , Help your king"
                        return false 
                    end
                end
            end
        end

        if color == 'black'
            all_other_whites.each do |ele|
                if (ele.special_capture_king(input))
                    if ele.special_capture_king(input).include?(input)
                        p "Check , Help your king"
                        return false 
                    end
                end
            end
        end



        all_blacks = [@black_queen,@black_rook1,@black_rook2,
            @black_bishop1,@black_bishop2]
        all_whites = [@white_queen,@white_rook1,@white_rook2,
            @white_bishop1,@white_bishop2]
            
        if color == 'white'
            all_blacks.each do |ele|
                if ele.steps_to_reach(input) != false 
                    if ele.steps_to_reach(input)[-1] == input
                        p "Check , Help your king"
                        return false 
                    end
                end
            end
        elsif color == 'black'
            all_whites.each do |ele|
                if ele.steps_to_reach(input) != false
                    if ele.steps_to_reach(input)[-1] == input
                        p "Check , Help your king"
                        return false 
                    end
                end
            end
        end
        return true
    end

require 'byebug'


    def one_piece_out(update_item,index_update,player_color,icon)
        
        # If the place is not empty then go check what is even in that place , if it is an empty then capture it else if that's the user's own piece deny the place 
        white_array = ['♔','♕','♖','♗','♘','♙']
        black_array = ['♚','♛','♜','♝','♞','♟']
        board = @chess_board.board
        chess_board_index = board[index_update[0]][index_update[1]]
        #This is for black
        if player_color == 'black' && white_array.include?(chess_board_index) && icon != '♟'
            board[update_item.current_place[0]][update_item.current_place[1]] = ' '
            update_item.move(index_update)
            board[update_item.current_place[0]][update_item.current_place[1]] = icon
            return true;
        # This is for white , figure out the rest yourself
        elsif player_color == 'white' && black_array.include?(chess_board_index) && icon != '♙'
            board[update_item.current_place[0]][update_item.current_place[1]] = ' '
            update_item.move(index_update)
            board[update_item.current_place[0]][update_item.current_place[1]] = icon
            return true;
        #This is for pawns , empty but holds great power within && Blacks only
        elsif player_color == 'black' && white_array.include?(chess_board_index) && icon == '♟'
            board[update_item.current_place[0]][update_item.current_place[1]] = ' '
            update_item.capture_move(index_update)
            board[update_item.current_place[0]][update_item.current_place[1]] = icon
            return true;
        #This is for pawn , empty but holds great power within && Whites only
        elsif player_color == 'white' && black_array.include?(chess_board_index) && icon == '♙'
            board[update_item.current_place[0]][update_item.current_place[1]] = ' '
            update_item.capture_move(index_update)
            board[update_item.current_place[0]][update_item.current_place[1]] = icon
            return true;
        else
            return false
        end
    end


    def step_valid(chess_piece,input)
        # King and pawn will not have a checking for valid_steps cause they only move one step at a time
        return true if defined?(chess_piece.bool)
        return true if defined?(chess_piece.dont_touch)
        board = @chess_board.board
        return true if chess_piece.steps_to_reach(input) == false
        array = chess_piece.steps_to_reach(input)
        array.pop
        if array != []
            array.each do |ele|
                return false if board[ele[0]][ele[1]] != ' '
            end
            return true
        else
            return true
        end
    end


    def show_chess_board
   


        puts '----------------------------------------'
        puts '-----------------Board------------------'
        puts '----------------------------------------'
        puts '----------------------------------------'
        @chess_board.board.each {|ele| p ele}
        puts '----------------------------------------'
        puts '----------------------------------------'
        puts '----------------------------------------'
        puts '----------------------------------------'


    end

    

    
end


def playing
    puts "Tell me your name dear 1st player"
    first_player_name = gets.chomp
    puts "Tell me your name dear 2nd player"
    second_player_name = gets.chomp
    puts "Here we go"
    game = ChessGame.new("#{first_player_name}","#{second_player_name}")
    game.play_game

end

playing