# Silly blocks

	def reverser
		word = yield
		new_word = ""
		word.split.each {|x| new_word += (x.reverse) + " "}
		return new_word.chop
		end

	def adder(inc=1)
		num = yield
		num += inc
	end

	def repeater(num=1)
		num.times do 
			yield
		end
	end
