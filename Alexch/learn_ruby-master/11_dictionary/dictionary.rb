# Dictionary

class Dictionary

	attr_accessor :entries, :keywords

	# empty at creation
	def initialize
		@entries = {}
	end

	# can add a word with or without definition
	def add(word)
		if word.class == String
			word = {word => nil}
		end

		word.each do |key, value|
			@entries[key] = value
		end
	end

	# adds keywords
	def keywords
		keys = []
		@entries.each do |key, value|
			keys << key
		end
		keys.sort
	end

	# checks if keywords exist
	def include?(key)
		self.keywords.include?(key)
	end

	# finds using key prefix
	def find(prefix)
		found_entries = entries.select do |key, value|
			key[0...prefix.length] == prefix
		end
	end

	# creates printable version of itself in A-Z order
	def printable
		@entries.sort.map do |key, value|
			"[#{key}] \"#{value}\""
		end.join("\n")
	end
end


