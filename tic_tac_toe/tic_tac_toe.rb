require "./ttt_logic.rb"

play_pos = 1
played_pos = []
board = GameBoard.new
players = Players.new("X","O")
won = false

puts "\nWelcome to Tic-Tac-Toe. Programmed in Ruby"
players.list
puts "Press the key that corresponds to the spot below to place your marker there. Eg: \n\n"
puts " 7 | 8 | 9"
puts "---|---|---"
puts " 4 | 5 | 6"
puts "---|---|---"
puts " 1 | 2 | 3\n\n"

board.display

while won == false
	played_pos.push(players.get_pos(play_pos))
	if played_pos.count(played_pos.last) == 1
		if board.place(played_pos.last, " ") #This!
			board.place(played_pos.last, players.get_marker(play_pos))
			if board.win_condition
				puts "\n\n**#{players.get_marker(play_pos)} player has won!**"
				puts "Thanks for Playing!"
				won = true
			elsif played_pos.length == 9
				puts "\n\n**Draw game, baby!**"
				puts "Thanks for playing."
				won = true
			end
			if play_pos == 1
				play_pos = 2
			else 
				play_pos = 1
			end
		else
			puts "**Please input a number between 1-9.**"
			played_pos.pop	 	
		end
		board.display
	else
		puts "**Spot #{played_pos.last} is already full, pick another.**"
		played_pos.pop
	end
end