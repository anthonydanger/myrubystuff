# Temperature

	def ctof(temp_c)
		temp_c = ((temp_c.to_f * 9.0)/5.0) + 32.0
	end

	def ftoc(temp_f)
		temp_f = ((temp_f.to_f - 32.0) * 5.0)/ 9.0
	end
