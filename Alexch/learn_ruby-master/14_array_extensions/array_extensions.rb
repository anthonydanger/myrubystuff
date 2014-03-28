# array_extensions.rb

class Array
	def sum
		inject(0, :+)
	end

	def square
		self.map do |x|
			x * x
		end
	end

	def square!
		self.map! do |x|
			x * x
		end
	end
end