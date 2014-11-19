require "./mastermind_logic.rb"

# Main program script for Ruby Mastermind in the commandline.
puts "\e[H\e[2J" #CLEAR SCREEN
puts "**Welcome to Mastermind programmed in Ruby.**".center(80)
puts "\n\nYou have 12 chances to guess the code. The code is made up of 4 digits of any\ncombination of the numbers 1-6. Each guess you make has a response of either\n = or +. At the end of each round the Code Maker is awarded with points \nequaling how many guesses it took the Code Breaker to a maximum of twelve.\n\n= : 1 position correct.\n+ : 1 digit correct but it\'s in the wrong position. \n\nGood Luck\n\n"

gets
menu = nil

# Game Play Logic

def code_set
	set_code = ""
		puts "\e[H\e[2J"
		puts "Please input your the code.\n"
			until set_code.length == 4 #Parsing code input.
				puts "\tYou need a code of 4 digits between 1-6.\n" if set_code.length != 4
				set_code = gets.chomp				
				set_code = set_code.split(//)			
				set_code.map! { |e| e.to_i }
				set_code.reject! {|i| i > 6 || i < 1}
			end
	set_code
end

def game_loop(code_breaker, code_creator, set_code=nil)
	board = GameBoard.new
	x = 12
	won = false

	board.code = set_code if code_breaker.human == false

	while x >= 1 && won == false

		if x == 12 || code_breaker.human == true
			guess_list_return = board.guess_check(code_breaker.guess(x))
		elsif x != 0 && won != true
			board.guess_check(code_breaker.guess(x,guess_list_return))
		end

		if board.display == true
			won = true
			puts "Code Maker awarded #{12-x} points."
			code_creator.points += 12 - x
		end
		x -= 1
	end

	if x == 0 && won == false
		puts "\n\nSorry... you didn't break the code."
		puts "The code was: #{board.code}\n\n"

		code_creator.points += 12
		puts "**Code Maker awarded 12 points.**\n\n"
	end
end

# High level game path
def start_game(start)
	winning = ""
	human = Player.new(true)
	ai = Player.new(false)
		if start
			game_loop(human,ai)
			game_loop(ai, human, code_set)
		else		
			game_loop(ai,human,code_set)
			game_loop(human, ai)
		end

	if human.points == ai.points
		winning = "it's a tie game."
	elsif human.points > ai.points
		winning = "you are winning."
	else
		winning = "the computer is winning."
	end

	puts "After 2 rounds, #{winning} The scores are:\n\n"
	puts "You:".rjust(8) + " #{human.points}"
	puts "Ai:".rjust(8) + " #{ai.points}"
	puts "\n**Play another round?**\n"
	puts "Enter to continue."
	gets
end

#Game Menu

while menu != 3
	puts "\e[H\e[2J"
	puts "Would you like to guess first or create the code?\n\n"
	puts "1 : Guess the Code"
	puts "2 : Create the Code"
	puts "3 : Exit Mastermind\n"
	menu = gets.chomp.to_i
	if menu == 1
		start_game(true)
	elsif menu == 2		
		start_game(false)
	elsif menu == 3
		break
	else
		puts "\e[H\e[2J"
		puts "**Please select a option listed.**"
	end
end


puts "\n\nThanks for playing!"
puts "**Coded by Peter Segal!**\n\n"

