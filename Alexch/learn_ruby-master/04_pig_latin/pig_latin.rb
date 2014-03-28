# Pig Latin

def translate(y)
	letters = ('a'..'z').to_a
	cap_letters = ('A'..'Z').to_a
	vowels = %w[a e i o u]
	consonants = letters - vowels

	# sends |word| to one of two functions depending on capitalization
	y = y.split(' ').map { |word| cap_letters.include?(word[0]) ? latinize_up(word) : latinize_lc(word) }

	y.join(' ')
	
end

# function for lower case letters
def latinize_lc(x)
	letters = ('a'..'z').to_a
	vowels = %w[a e i o u]
	consonants = letters - vowels
	
	if vowels.include?(x[0..0])
		x + 'ay'
	elsif x[0..2] == 'squ'
		x[3..-1] + 'squay'
    elsif consonants.include?(x[0..0]) && consonants.include?(x[1..1]) && consonants.include?(x[2..2])
		x[3..-1] + x[0..2] + 'ay'
	elsif consonants.include?(x[0..0]) && consonants.include?(x[1..1]) 
		x[2..-1] + x[0..1] + 'ay'
	elsif x[0..1] == 'qu'
		x[2..-1] + 'quay'
	else consonants.include?(x[0])
		x[1..-1] + x[0..0] + 'ay'
	end


end

# function for upper case letters
def latinize_up(x)
	letters = ('A'..'Z').to_a
	vowels = %w[A E I O U]
	consonants = letters - vowels
	lower_case_letters = ('a'..'z').to_a
	lower_case_vowels = %w[a e i o u]
	lower_case_consonants = lower_case_letters - lower_case_vowels
	
	if vowels.include?(x[0..0])
		(x.downcase + 'ay').capitalize
	elsif x[0..2] == 'Squ'
		(x[3..-1].downcase + 'squay').capitalize
	elsif x[0..1] == 'Qu'
		(x[2..-1].downcase + 'quay').capitalize
    elsif consonants.include?(x[0..0]) && lower_case_consonants.include?(x[1..1]) && lower_case_consonants.include?(x[2..2])
		(x[3..-1].downcase + x[0..2] + 'ay').capitalize
	elsif consonants.include?(x[0..0]) && lower_case_consonants.include?(x[1..1]) 
		(x[2..-1].downcase + x[0..1] + 'ay').capitalize
	else consonants.include?(x[0])
		(x[1..-1].downcase + x[0..0] + 'ay').capitalize
	end


end
