class Window
	#pauses game until player presses enter key
	def pause 
	STDIN.gets
	end
end

class Game 
	$tiles = [0, 1, 2, 3, 4, 5, 6, 7, 8] 

	def greetings
		puts"Welcome to tic-tac-toe version 1.0 by Jeff Maxim!"
		puts"Press enter if you're ready to start"
		Screen.pause
	end

	def instructions
	written_instructions = <<-END
This is tic-tac-toe!
Player X goes first. 
Line up three squares in a row (horizontally, vertically, diagonally) to win!
Game ends with a win or when all 9 squares are filled.
Winning player gets all the glory!

END
	puts written_instructions
	end

	def show_board(player)

		flag = true
		while flag	
			board_generator
			move = move_getter(player) 

			if good_player_move(move)
				flag = false
			elsif !good_player_move(move)
				puts"Invalid move. Try Again player #{player}"
			end
		end
		return move
	end

	def board_generator
		@board = [
		["#{$tiles[0]}", "#{$tiles[1]}", "#{$tiles[2]}"],
		["#{$tiles[3]}", "#{$tiles[4]}", "#{$tiles[5]}"],
		["#{$tiles[6]}", "#{$tiles[7]}", "#{$tiles[8]}"]
		]
		@board.each do |row|
			print "|"
			row.each { |cell| print "#{cell}|" }
			puts "\n-------"
		end
	end

	def move_getter(player)
		move = nil # initialize the variable so you can invoke methods on it
		until move.is_a?(Fixnum) do
			puts "It's your turn player #{player}."
			puts "Please enter the number where you wanna place your #{player}: "
			move = Integer(gets) rescue nil
		end
		return move
	end

	def good_player_move(move)
		return false if move != $tiles[move]
		return true 
	end

	def play
		player = "X"
		number_moves = 0
		flag = true
		while flag
			square = show_board(player)
			$tiles[square] = player if square == $tiles[square]
			number_moves += 1
			winner = win?(player)
			flag = winner_if?(winner, number_moves)
			player = player_switcher(player)
		end
	end

	def winner_if?(winner, number_moves)
		if winner == "X"
			game_over("player X wins")
			return false
		elsif winner == "O"
			game_over("player O wins")
			return false
		elsif number_moves > 8
			game_over("tie")
			return false
		end
		return true
	end

	def win?(player)
		(0..2).each do |i|
			if $tiles[i] == player && $tiles[i+3] == player && $tiles[i+6] == player #check for vertical win
				return player
			elsif $tiles[(i*3)] == player && $tiles[(i*3) + 1] == player && $tiles[(i*3) + 2] == player #check for horizontal win
				return player
			end
		end

		#check for diagonal wins
		if $tiles[0] == player && $tiles[4] == player && $tiles[8] == player
			return player
		elsif $tiles[2] == player && $tiles[4] == player && $tiles[6] == player
			return player
		end
		return false
	end

	def game_over(statement)
		puts statement
	end

	def player_switcher(player)
		if player == "X"
			return("O")
		else
			return("X")
		end
	end

	def credits
		puts "Game Over"
		puts "Developed by Jeff Maxim"
		puts "I wanna go to Recurse Center!"
	end
end

Screen = Window.new
new_game = Game.new
new_game.greetings
new_game.instructions
new_game.play
new_game.credits
