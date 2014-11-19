class GameBoard
	attr_accessor :code

	def initialize
		@code = [0,0,0,0]
		@code.fill {|x| 1 + rand(6)}
		@guess_list = []
	end 

	def generate
		@code.fill {|x| 1 + rand(6)}
	end

	def guess_check(array)
		response = []
		array_check = []
		code_check = []
		
		@code.each_index do |i|	
			if array[i] == @code[i]
				response.push("=")
			else 
				array_check.push(array[i])
				code_check.push(@code[i])
			end
		end
		array_check.length.times do |i|
			code_check.length.times do |j|
				if array_check[i] == code_check[j]
					response.push("+")
					array_check[i] = 0
					code_check[j] = 7
				end
			end
		end

		@guess_list.push([array,response])
	end

	def display
		i = -1
		win_condition = ["=","=","=","="]
		puts "\e[H\e[2J"

		puts "Guess history:"
		@guess_list.each do |guesses|
			puts "#{i += 1}#".ljust(7) + "#{guesses[0].join(' ')}   |   #{guesses[1].join()}"
		end
		
		if @guess_list.last[1].eql?(win_condition)
			puts "\n\n**Congradulations you have broke the code!**\n\n"
			return true
		end
	end
end

class Player
	attr_accessor :points
	attr_reader :human

	def initialize(human)
		@human = human
		@points = 0
		a = [1,2,3,4,5,6]
		@possibilities = a.repeated_permutation(4).to_a
	end

	def guess(num, guess_res=nil)
		response = ""
		if @human
			puts "Please input your guess. You have #{num} guesses left.\n"
			until response.length == 4
				puts "\tYou need a guess of 4 digits between 1-6.\n" if response.length != 4
				response = gets.chomp				
				response = response.split(//)			
				response.map! { |e| e.to_i }
				response.reject! {|i| i > 6 || i < 1}
			end
		response
		else
			if num == 12
				[1,1,2,2]
			else
				knuth_solver(guess_res)
			end		
		end
	end

	private 

	def knuth_solver(res)
		@possibilities.each do |x|
			unless res_check(res.last[0],x).eql?(res.last[1])
				@possibilities.delete(x)
			end
		end		
		@possibilities.sample
	end

	def res_check(set_code, chk_code)
		response_result = []
		array_check = []
		code_check = []
		
		set_code.each_index do |i|	
			if chk_code[i] == set_code[i]
				response_result.push("=")
			else 
				array_check.push(chk_code[i])
				code_check.push(set_code[i])
			end
		end
		array_check.length.times do |i|
			code_check.length.times do |j|
				if array_check[i] == code_check[j]
					response_result.push("+")
					array_check[i] = 0
					code_check[j] = 7
				end
			end
		end
		response_result
	end

end
