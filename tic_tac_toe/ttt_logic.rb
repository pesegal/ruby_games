# Command Line Tic Tac Toe Game

class GameBoard
	def initialize 
		@board = [[' ',' ',' '],
				  [' ',' ',' '],
				  [' ',' ',' ']]
	end

	def place(loc, type)
		case loc
			when 1
				@board[2][0] = type
			when 2
				@board[2][1] = type
			when 3
				@board[2][2] = type
			when 4
				@board[1][0] = type
			when 5
				@board[1][1] = type
			when 6
				@board[1][2] = type
			when 7
				@board[0][0] = type
			when 8
				@board[0][1] = type
			when 9
				@board[0][2] = type
			else
				return false #catch other input
		end
	end

	def display
		puts "\n #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
		puts "---|---|---"
		puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
		puts "---|---|---"
		puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}\n\n"
	end

	def win_condition
		3.times do |i|			
			return true if @board[i][0] == @board[i][1] && @board[i][0] ==  @board[i][2] && @board[i][0] != ' '
			return true if @board[0][i] == @board[1][i] && @board[0][i] ==  @board[2][i] && @board[0][i] != ' '
		end
			return true if @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2] && @board[0][0] != ' '
			return true if @board[2][0] == @board[1][1] && @board[2][0] == @board[0][2] && @board[2][0] != ' '
	end
end

class Players	
	def initialize(*markers)
		i = 0
		@players = []
		markers.each do |marker|
			i += 1
			@players.push([i,marker])
		end
	end

	def list
		puts "\nThere are #{@players.length} players: \n"
		@players.each {|x| puts "Player #{x[0]} is #{x[1]}."}
	end

	def get_pos(num)
		puts "\n"
		puts "It's player #{@players[num - 1][1]}\'s turn."
		gets.to_i
	end

	def get_marker(num)
		@players[num - 1][1]
	end

end