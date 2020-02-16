class TicTacToe

        def initialize(board = nil)                                     #makes intial board as an empty array
          @board = board || Array.new(9, " ")                           #9 empty spots
        end
       WIN_COMBINATIONS = [                                             #all the differnt ways you can win
            [0,1,2],
            [3,4,5],
            [6,7,8],
            [0,4,8],
            [0,3,6],
            [1,4,7],
            [2,5,8],
            [2,4,6]  
           ]

        def current_player                                              #allows player to return proper x,o to the board      
          turn_count % 2 == 0 ? "X" : "O"
        end
       
        def turn_count
          @board.count{|token| token == "X" || token == "O"}            #remebers what goes where
        end
       
        def display_board                                               #displays board in instance variablees with proper index
          puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
          puts "-----------"
          puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
          puts "-----------"
          puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        end

        def input_to_index(user_input)                              #accepts the users input as argument
            user_input.to_i - 1                                     #converts to integer 
        end                                                         #converts to proper index, like if they choose 1 its actually 0

        def move(index, current_player = "X")                       #makes your moves an x and saves to the index
            @board[index] = current_player
          end
          
          def position_taken?(index)                                #checks to see if the position is taken or not
            !(@board[index].nil? || @board[index] == " ")
          end
          
          def valid_move?(index)
            index.between?(0,8) && !position_taken?(index)          #uses position taken to check if the space is occupied 
          end                                                       #also makes sure the move is within the index
          
          def turn_count                                            #after you choose x or o the turn count will go up
            turn = 0                                                #remembers number of occupied positions
            @board.each do |index|
              if index == "X" || index == "O"
                turn += 1
              end
            end
            return turn
          end
          
          #def current_player
                                 #if the turn count is an even number, that means O just went, so the next/current player is X
          #  num_turns = turn_count
           # if num_turns % 2 == 0
           #   player = "X"
           # else
          #    player = "O"
          #  end
          #  return player
         # end
          
          def turn                                          #after asking, gets the user input 
            puts "Please choose a number 1-9:"
            user_input = gets.chomp                         #actually gets the argument we use for other methods
            index = input_to_index(user_input)              #index comes from our input methods
            if valid_move?(index)                           # checks to see if inputed index is a valid move
              player_token = current_player                 # player token has been asigned before
              move(index, player_token)                     # allows you to choose a spot and put your token there
              display_board                                 # returns the borard                
            else                                            #then reruns the method
              turn
            end
          end
          
          def won?
            WIN_COMBINATIONS.each {|win_combo|                      #if the positons yoy have chosen match a combo then it checks it
              index_0 = win_combo[0]
              index_1 = win_combo[1]
              index_2 = win_combo[2]
          
              position_1 = @board[index_0]
              position_2 = @board[index_1]
              position_3 = @board[index_2]
          
              if position_1 == "X" && position_2 == "X" && position_3 == "X"
                return win_combo
              elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
                return win_combo
              end
            }
            return false
          end
          
          def full?
            @board.all? {|index| index == "X" || index == "O"}                      #checks if the board is full
          end
          
          def draw?
            if !won? && full?               #if the won method is fufilled and its full it returns draw or not
              return true
            else
              return false
            end
          end
          
          def over?                         #if you won or got a draw its over
            if won? || draw?
              return true
            else
              return false
            end
          end
          
          def winner
            index = []                              #empty array filled with the won return array false or ture 
            index = won?
            if index == false
              return nil
            else
              if @board[index[0]] == "X"
                return "X"
              else
                return "O"
              end
            end
          end
          
          def play                                              #takes turns till its over
            until over? == true
              turn
            end
          
            if won?                                             #prints out game text
              puts "Congratulations #{winner}!"
            elsif draw?
              puts "Cat's Game!"
            end
          end
          
          end