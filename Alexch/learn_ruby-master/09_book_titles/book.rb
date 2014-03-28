# Book Title

class Book
	
	attr_reader :title

	def title=(t)
		@title = Book.titleize(t)
	end

	private

		def self.titleize(str)
			little_words = %w{the a by on for of are with and just but an and to over the my is in I has some}
			str = str.split(' ').map {|word| little_words.include?(word) ? word.downcase : word.capitalize}
			str[0] = str[0].capitalize
			str.join(' ')
		end
	end