require "./hm_logic.rb"
require "pstore"

def input_check(input, guess_word)
	checkloop = true
	alphabet = %w{a b c d e f g h i j k l m n o p q r s t u v w x y z}
	while checkloop
		if alphabet.include?(input) || input == "quit" || input == "save"
			checkloop = false
			if guess_word.include?(input)
				puts "You have already guessed '#{input}' please chose another letter."
				input = gets.chomp.downcase
				checkloop = true
			end
		else
			puts "Please enter a letter between a-z or save / quit."
			input = gets.chomp.downcase
		end
	end
	input
end

#Initilization

word_array = []
menu = nil
saved_game = nil
store = PStore.new("hangman.sv")

File.open("5desk.txt").each do |word|
	if word.chomp.length >= 5 && word.chomp.length <= 12
		word_array.push(word)
	end
end

store.transaction do
	saved_game = store[:game]
end 

puts "Welcome to hangman! Programmed in Ruby\n\n"

if saved_game == nil
	word = GameObject.new(word_array.sample.chomp.downcase.split(//))
else
	puts "Load the saved game? yes | no\n #{saved_game.display_array.join(' ')} Guesses remaining: #{saved_game.num_of_guesses}\n"
	menu = gets.chomp
	if menu == "no"
		puts "\n\nNew game started!\n\n"
		word = GameObject.new(word_array.sample.chomp.downcase.split(//))
	else
		puts "\n\nLoading game #{saved_game.display_array.join}\n\n"
		word = saved_game
	end
end



# Main Game Loop

while menu != "quit"
	puts "Please Select a letter from a-z | Type 'save' to save the game or 'quit' to exit.\n\n"
	word.display

	if word.num_of_guesses > 0 && word.win_condition != true
		menu = input_check(gets.chomp.downcase, word.guess_array)
		if menu != 'quit' && menu != 'save'
			word.guess(menu)
		elsif menu == 'save'
			store.transaction do
				store[:game] = word
				p "Stored!"
			end
			menu = "quit"
		end

	elsif word.win_condition
		puts "Contgrats you have guessed the word."
		store.transaction do
			store.delete(:game)
		end
		menu = "quit"
	else
		puts "Sorry you didn't guess correctally."
		puts "The word is: #{word.word_array.join.capitalize}\n\n"
		store.transaction do
			store.delete(:game)
		end
		menu = "quit"
	end
end