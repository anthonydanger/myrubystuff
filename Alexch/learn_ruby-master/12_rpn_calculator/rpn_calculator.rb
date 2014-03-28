# RPN calculator    

class RPNCalculator

    attr_accessor :calculator

    def initialize
        self.calculator = Array.new
    end
    
    def plus
        raise "calculator is empty" unless self.calculator.size >= 2
        value1 = self.calculator.pop #3
        value2 = self.calculator.pop #2
        value3 = value1 + value2
        self.calculator.push(value3)
    end
    
    def minus
        raise "calculator is empty" unless self.calculator.size >= 2
        value1 = self.calculator.pop
        value2 = self.calculator.pop
        value3 = value1 - value2
        self.calculator.push(value3)
    end
    
    def divide
        raise "calculator is empty" unless self.calculator.size >= 2
        value1 = self.calculator.pop
        value2 = self.calculator.pop
        value3 = value1.to_f / value2.to_f
        value3 = value3
        self.calculator.push(value3)
    end

    def times
        raise "calculator is empty" unless self.calculator.size >= 2
        value1 = self.calculator.pop
        value2 = self.calculator.pop
        value3 = value1.to_f * value2.to_f
        self.calculator.push(value3)
    end

    def push(new_value)
        self.calculator << new_value
    end

    def value
        self.calculator.last.to_f
    end

    def evaluate(str)
        tokens(str).each do |x|
            if x == :+
                plus
            elsif x == :-
                minus
            elsif x == :/
                divide
            elsif x == :*
                times
            else
                push(x)
            end
        end
        value
        
    end

    def tokens(str)
        str.split.map do |x|

            if x == "+"
                :+
            elsif x == "-"
                :-
            elsif x == "/"
                :/
            elsif x == "*"
                :*
            else
                x.to_i
            end
        end
    end
end
