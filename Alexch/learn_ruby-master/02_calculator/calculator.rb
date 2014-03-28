# Calculator

# addition function
def add(x,y)
	x + y
end

# subtraction function
def subtract(x,y)
	x - y
end

# sum function
def sum(array)
	array.inject(0){|sum,x| sum + x}
end

# Bonus Round

# multiplication function
def multiply(array)
	array.inject(1){|product,x| product * x}
end

# exponent function
def power(x,y)
	x**y
end

# factorial function
def factorial(x)
	if x <= 1
		1
	else
		x * factorial(x - 1)
	end
end