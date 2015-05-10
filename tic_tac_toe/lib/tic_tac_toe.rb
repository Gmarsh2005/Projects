# Gray Marsh's version 1.3 TicTacToe
module TicTacToe
  class GameBoard
    attr_accessor :board
    def initialize
      @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @run = true
    end
    

    def show_board
      c = 0
      3.times do
    	  puts @board[c].to_s + " " + @board[c+1].to_s + " " + @board[c+2].to_s
        c += 3
      end
      return " "
    end

    def turn_x
    	show_board
    	puts "Please choose from 1-9 to place your X."
    	choice = gets.chomp.to_i
      if @board.include? (choice)
        @board.map! do |element|
        	if element == choice
        		element = "X"
        	else
        		element
        	end
        end
      else
      	puts "Invalid choice!  Choose again."
      	turn_x
      end
    end

    def turn_o
    	show_board
    	puts "Please choose from 1-9 to place your O."
    	choice = gets.chomp.to_i
    	if @board.include? (choice)
    	  @board.map! do |element|
    		if element == choice
    		  element = "O"
    		else
    			element
    		end
    	  end
    	else
    		puts "Invalid choice!  Choose again."
    		turn_o
    	end
    end

    def winner
    	result = false
      a = 0
      b = 0
      3.times do      #checking horizontal win
    	if @board[a] == @board[a+1] && @board[a] == @board[a+2]
    	    result = true
    	  end
    	a += 3
    	end
      3.times do      #checking vertical win
        if @board[b] == @board[b+3] && @board[b] == @board[b+6]
            result = true
        end
        
        b += 1
      end
                      #checking diagonal win
      if @board[0] == @board[4] && @board[0] == @board[8]
        result = true
      elsif @board[6] == @board[4] && @board[6] == @board[2] 
        result = true
      end
    	result
    end

    def tie
      board.all? { |matrix| matrix.is_a? String}
    end


  def game_result
    if winner
      show_board
      puts "Game Over!"
      @run = false
    elsif tie
      show_board
      puts "It's a tie!"
      @run = false
    end
  end

    def run_game
    	while @run
    		turn_x
        game_result
        break unless @run == true
    		turn_o
        game_result
      end

    end

    def take_cross
      if @board[0].is_a? Fixnum
        @board[0] = "O"
        turn_over = true
      elsif @board[2].is_a? Fixnum
        @board[2] = "O"
        turn_over = true
      elsif @board[6].is_a? Fixnum
        @board[6] = "O"
        turn_over = true
      elsif @board[8].is_a? Fixnum
        @board[8] = "O"
        turn_over = true
      end
      turn_over
    end

    def take_side
      if @board[1].is_a? Fixnum
        @board[1] = "O"
        turn_over = true
      elsif @board[7].is_a? Fixnum
        @board[7] = "O"
        turn_over = true
      elsif @board[3].is_a? Fixnum
        @board[3] = "O"
        turn_over = true
      elsif @board[5].is_a? Fixnum
        @board[5] = "O"
        turn_over = true    
      end
      turn_over
    end


    def artificial
      #if choice results in win for self, execute.
      turn_over = false
      d = 0
      while d < 9
        original_element = @board[d]
        @board[d] = "O" unless @board[d] == "X"
        if winner
          turn_over = true
          d = 9
        else
          @board[d] = original_element
          d += 1
        end
      end
   
      #or if choice blocks a win for opponent, execute.
      unless turn_over
        d = 0
        while d < 9
          original_element = @board[d]
          @board[d] = "X" unless @board[d] == "O"
          puts original_element
          if winner
            turn_over = true
            @board[d] = "O"  
            d = 9
          else      
            @board[d] = original_element
            d += 1
          end
        end

      end

      unless turn_over
        unless @board[4].is_a? String
          @board[4] = "O"
          turn_over = true
        end
      end

      unless turn_over
        if @board[4] == "O"
          take_side || take_cross
        else  
          take_cross || take_side
        end       
      end
    end

        

    def ai_game
      while @run
        turn_x
        game_result
        break unless @run == true
        artificial
        game_result
      end
    end

  end
end

# TicTacToe
# playing = true
# while playing
#   round = TicTacToe::GameBoard
#   puts "Welcome to tic-tac-toe! Return A to play hard mode or any other key to play 2-player."
#   game_type = gets.chomp.upcase
#   if game_type == "A"
#     round.new.ai_game
#   else
#     round.new.run_game
#   end
#   puts "Return N to quit; enter any other key to play again."
#   replay = gets.chomp.upcase
#   if replay == "N"
#     playing = false
#   end
# end