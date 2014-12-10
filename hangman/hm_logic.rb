class GameObject

	attr_reader :num_of_guesses, :word_array, :guess_array, :display_array

	def initialize(word)
		@word_array = word
		@guess_array = []
		@display_array = @word_array.dup.fill("_")
		@num_of_guesses = word.length
	end

	def display
		puts "\nCurrent: #{@display_array.join(" ")}"
		puts "Guessed: #{@guess_array.join(" ")}"
		puts "\nGuesses Left: #{@num_of_guesses}\n\n"
	end

	def guess(letter)
		exist_flag = false
		@word_array.each_index do |i|
			if @word_array[i] == letter
				@display_array[i] = letter
				exist_flag = true
			end
		end

		unless exist_flag
			@guess_array.push(letter)	
			@num_of_guesses -= 1
		end

	end

	def win_condition
		@word_array == @display_array
	end

end