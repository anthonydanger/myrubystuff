# Timer

class Timer
	attr_accessor :seconds

	def initialize
		@seconds = 0
	end

	def time_string
		hours = @seconds / (60 * 60)
		minutes = (@seconds % (60 * 60)) / 60
		seconds = (@seconds % 60)

		[Timer.time(hours), Timer.time(minutes), Timer.time(seconds)].join(":")
	end

	private
		def Timer.time(str)
			(str < 10) ? "0#{str}" : str.to_s
		end
	end
