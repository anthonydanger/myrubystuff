# Simon Says

# Echo a word
def echo(x)
	p x
end

# Shout a word(s)
def shout(x)
	p x.upcase
end

# Repeat a word or phrase
def repeat(x, y=2)
	i = (x + ' ') * y	
	p i.to_s.rstrip
end

# Start of word
def start_of_word(x,y)
	i = x.scan(/./)
	i[0...y].join
end

# Show the First Word
def first_word(x)
	x.split(' ')[0]
end

# Appropriately Capitalize a Title
def titleize(x)
	
	little_words = %w{the a by on for of are with and just but an and to over the my is in I has some}

	x = x.split(' ').map {|word| little_words.include?(word) ? word.downcase : word.capitalize}

	x[0] = x[0].capitalize

	x.join(' ')
end